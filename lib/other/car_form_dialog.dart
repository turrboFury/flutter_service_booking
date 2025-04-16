import 'package:flutter/material.dart';

class CarFormDialog extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  const CarFormDialog({super.key, required this.onSave});

  @override
  _CarFormDialogState createState() => _CarFormDialogState();
}

class _CarFormDialogState extends State<CarFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _brandModelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _vinController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;


  String _fuelType = "Benzină";

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: isStart
          ? (_startTime ?? TimeOfDay(hour: 9, minute: 0))
          : (_endTime ?? TimeOfDay(hour: 10, minute: 0)),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  String _format24h(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  void _saveForm() {
    if (_formKey.currentState!.validate() && _validateTimeInterval()) {
      final carData = {
        "Număr înmatriculare": _licensePlateController.text,
        "Marca și modelul": _brandModelController.text,
        "Anul fabricației": _yearController.text,
        "Kilometraj": _mileageController.text,
        "Tip combustibil": _fuelType,
        "Descriere": _descriptionController.text,
        "VIN": _vinController.text,
        "Interval orar": "${_format24h(_startTime!)} - ${_format24h(_endTime!)}"

      };

      print('car data: ${carData}');
      if (_startTime == null || _endTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selectează un interval orar complet")),
        );
        return;
      }

      final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
      final endMinutes = _endTime!.hour * 60 + _endTime!.minute;

      if (endMinutes <= startMinutes) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ora de sfârșit trebuie să fie după cea de început")),
        );
        return;
      }

      widget.onSave(carData);
      Navigator.pop(context); // Închide pop-up-ul
    }
  }

  @override
  void initState() {
    super.initState();

    // Pre-populare pentru test
    _licensePlateController.text = "B 123 ABC";
    _brandModelController.text = "Dacia Logan";
    _yearController.text = "2018";
    _mileageController.text = "85000";
    _descriptionController.text = "Revizie periodică";
    _vinController.text = "wbaxzy123";
    _fuelType = "Benzină"; // deja default, dar poți schimba la altceva dacă vrei
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă programare"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _licensePlateController,
                decoration: InputDecoration(labelText: "Număr înmatriculare"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Introduceți numărul de înmatriculare";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _brandModelController,
                decoration: InputDecoration(labelText: "Marca și modelul"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Introduceți marca și modelul";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Anul fabricației"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Introduceți anul fabricației";
                  }
                  if (int.tryParse(value) == null ||
                      int.parse(value) < 1900 ||
                      int.parse(value) > DateTime.now().year) {
                    return "Introduceți un an valid";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mileageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Kilometraj"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Introduceți kilometrajul";
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 0) {
                    return "Introduceți un kilometraj valid";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _vinController,
                decoration: InputDecoration(labelText: "VIN"),
              ),
              DropdownButtonFormField<String>(
                value: _fuelType,
                items:
                    ["Benzină", "Motorină", "Electric", "Hibrid"]
                        .map(
                          (fuel) =>
                              DropdownMenuItem(value: fuel, child: Text(fuel)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _fuelType = value!;
                  });
                },
                decoration: InputDecoration(labelText: "Tip combustibil"),
              ),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(labelText: "Descrierea problemei"),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => _pickTime(isStart: true),
                      child: Text(_startTime == null
                          ? "Ora început"
                          : "Începe: ${_format24h(_startTime!)}"),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _pickTime(isStart: false),
                      child: Text(_endTime == null
                          ? "Ora sfârșit"
                          : "Se termină: ${_format24h(_endTime!)}"),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Anulează"),
        ),
        ElevatedButton(onPressed: _saveForm, child: Text("Salvează")),
      ],
    );
  }

  bool _validateTimeInterval() {
    print('_starttime: ${_startTime} || _endTime: ${_endTime}');
    if (_startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selectează ambele ore pentru intervalul orar")),
      );
      return false;
    }

    final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
    final endMinutes = _endTime!.hour * 60 + _endTime!.minute;

    final minAllowed = 7 * 60; // 07:00
    final maxAllowed = 24 * 60; // 00:00 (miezul nopții)

    if (startMinutes < minAllowed || endMinutes > maxAllowed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Intervalul trebuie să fie între 07:00 și 24:00")),
      );
      return false;
    }

    if (endMinutes <= startMinutes) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ora de sfârșit trebuie să fie după ora de început")),
      );
      return false;
    }

    return true;
  }

}

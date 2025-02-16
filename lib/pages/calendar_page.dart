import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<String>> _events = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  void _showCarFormDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CarFormDialog(
          onSave: (carData) {
            setState(() {
              _events[_selectedDay] = _events[_selectedDay] ?? [];
              _events[_selectedDay]!.add(
                "p",
                // adauga clasa programare
              );
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar Service Auto")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              rowHeight: 40,
              locale: "en_US",
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              focusedDay: _selectedDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              calendarFormat: _calendarFormat,
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              eventLoader: (day) => _events[day] ?? [],
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      bottom: 5,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showCarFormDialog,
              child: Text("Adaugă programare"),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children:
                    _events[_selectedDay]
                        ?.map((event) => ListTile(title: Text(event)))
                        .toList() ??
                    [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  String _fuelType = "Benzină";

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final carData = {
        "Număr înmatriculare": _licensePlateController.text,
        "Marca și modelul": _brandModelController.text,
        "Anul fabricației": _yearController.text,
        "Kilometraj": _mileageController.text,
        "Tip combustibil": _fuelType,
        "Descriere": _descriptionController.text,
      };

      widget.onSave(carData);
      Navigator.pop(context); // Închide pop-up-ul
    }
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
}

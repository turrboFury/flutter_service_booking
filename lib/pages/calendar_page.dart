import 'package:flutter/material.dart';
import 'package:flutter_service_booking/models/car.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../other/car_form_dialog.dart';
import 'car_details_page.dart';
import '../providers/appointment_provider.dart';
import '../models/appointment.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  void _showCarFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CarFormDialog(
          onSave: (carData) {
            final provider = Provider.of<AppointmentProvider>(
              context,
              listen: false,
            );
            provider.addAppointment(
              Appointment(
                car: Car(
                  licensePlate: carData["Număr înmatriculare"]!,
                  brandModel: carData["Marca și modelul"]!,
                  year: int.parse(carData["Anul fabricației"]!),
                  mileage: int.parse(carData["Kilometraj"]!),
                  fuelType: carData["Tip combustibil"]!,
                  vin: carData["VIN"]!,
                ),
                description: carData["Descriere"]!,
                date: _selectedDay,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);
    List<Appointment> selectedAppointments = provider.getAppointmentsForDay(
      _selectedDay,
    );

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
              onDaySelected: _onDaySelected,
              eventLoader: (day) => provider.getAppointmentsForDay(day),
            ),
            _selectedDay.isAfter(DateTime.now().subtract(Duration(days: 1)))
                ? ElevatedButton(
                  onPressed: () => _showCarFormDialog(context),
                  child: Text("Adaugă programare"),
                )
                : Text(""),

            Expanded(
              child:
                  selectedAppointments.isEmpty
                      ? Center(
                        child: Text("Nicio programare pentru această zi."),
                      )
                      : ListView.builder(
                        itemCount: selectedAppointments.length,
                        itemBuilder: (context, index) {
                          final appointment = selectedAppointments[index];

                          return Card(
                            child: ListTile(
                              title: Text(
                                "${appointment.car.licensePlate} - ${appointment.car.brandModel}",
                              ),
                              subtitle: Text(
                                "Kilometraj: ${appointment.car.mileage} km",
                              ),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CarDetailsPage(
                                          appointment: appointment,
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

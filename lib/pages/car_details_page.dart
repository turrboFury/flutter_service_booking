import 'package:flutter/material.dart';
import 'package:flutter_service_booking/models/car.dart';
import '../models/appoiment_history.dart';
import '../models/appointment.dart';
import 'package:provider/provider.dart';
import '../providers/appointment_provider.dart';

class CarDetailsPage extends StatelessWidget {
  final Appointment appointment;


  CarDetailsPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Detalii ${appointment.car.licensePlate}")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Marca și Modelul: ${appointment.car.brandModel}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("VIN: ${appointment.car.vin}"),
            Text("An fabricație: ${appointment.car.year}"),
            Text("Kilometraj: ${appointment.car.mileage} km"),
            Text("Tip combustibil: ${appointment.car.fuelType}"),
            SizedBox(height: 8),
            Text("Descriere:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(appointment.description),
            SizedBox(height: 16),
            Text(
              "Istoric reparații:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            // Aici poți adăuga un istoric real dacă ai datele necesare
            appointment.car.haveHistory()
                ? Expanded(
                  child: ListView.builder(
                    itemCount: 2 ,
                    itemBuilder: (context, index) {
                      print("appointment: $appointment");

                      // final appointment = selectedAppointments[index];
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
                )
                : Text("Nu exista un istoric in acest service"),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/appointment.dart';

class CarDetailsPage extends StatelessWidget {
  final Appointment appointment;

  const CarDetailsPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalii ${appointment.licensePlate}")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Marca și Modelul: ${appointment.brandModel}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("An fabricație: ${appointment.year}"),
            Text("Kilometraj: ${appointment.mileage} km"),
            Text("Tip combustibil: ${appointment.fuelType}"),
            SizedBox(height: 8),
            Text("Descriere:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(appointment.description),
            SizedBox(height: 16),
            Text(
              "Istoric reparații:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Aici poți adăuga un istoric real dacă ai datele necesare
            Text("Nu există încă reparații înregistrate."),
          ],
        ),
      ),
    );
  }
}

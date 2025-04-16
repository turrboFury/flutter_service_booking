import 'package:test/test.dart';
import 'package:flutter_service_booking/models/appointment.dart'; // Import your model file

void main() {
  group("Appointment Model Tests", () {
    test("Creating an appointment should store correct values", () {
      final appointment = Appointment(
        licensePlate: "B123XYZ",
        brandModel: "Dacia Logan",
        year: 2018,
        mileage: 75000,
        fuelType: "Benzină",
        description: "Schimb ulei",
        date: DateTime(2024, 2, 18),
      );

      expect(appointment.licensePlate, equals("B123XYZ"));
      expect(appointment.brandModel, equals("Dacia Logan"));
      expect(appointment.year, equals(2018));
      expect(appointment.mileage, equals(75000));
      expect(appointment.fuelType, equals("Benzină"));
      expect(appointment.description, equals("Schimb ulei"));
      expect(appointment.date, equals(DateTime(2024, 2, 18)));
    });

    test(
      "Two appointments on the same day should be recognized as the same day",
      () {
        final appointment1 = Appointment(
          licensePlate: "B123XYZ",
          brandModel: "Dacia Logan",
          year: 2018,
          mileage: 75000,
          fuelType: "Benzină",
          description: "Schimb ulei",
          date: DateTime(2024, 2, 18, 10, 30), // 10:30 AM
        );

        final appointment2 = Appointment(
          licensePlate: "B456XYZ",
          brandModel: "Ford Focus",
          year: 2020,
          mileage: 30000,
          fuelType: "Diesel",
          description: "Înlocuire plăcuțe frână",
          date: DateTime(2024, 2, 18, 16, 45), // 4:45 PM
        );

        bool isSameDay(DateTime date1, DateTime date2) {
          return date1.year == date2.year &&
              date1.month == date2.month &&
              date1.day == date2.day;
        }

        expect(isSameDay(appointment1.date, appointment2.date), isTrue);
      },
    );
  });

  group("DateTime Comparisons", () {
    test("Selected date should be after yesterday", () {
      DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
      DateTime selectedDay = DateTime.now();

      expect(selectedDay.isAfter(yesterday), isTrue);
    });

    test("Selected date should not be in the future", () {
      DateTime selectedDay = DateTime.now();
      DateTime futureDate = DateTime.now().add(Duration(days: 1));

      expect(selectedDay.isBefore(futureDate), isTrue);
    });
  });
}

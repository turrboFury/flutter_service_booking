import 'package:flutter_service_booking/models/appoiment_history.dart';
import 'package:flutter_service_booking/models/database.dart';

class Car {
  final String licensePlate;
  final String brandModel;
  final int year;
  final int mileage;
  final String fuelType;
  final String vin;

  Car({
    required this.licensePlate,
    required this.brandModel,
    required this.year,
    required this.mileage,
    required this.fuelType,
    required this.vin,
  });

  bool haveHistory() => Database().find(vin);
  AppointmentHistory? get getCarHistory {
    if (haveHistory()) {
      return Database().getCarHistory(vin);
    } else {
      throw Exception("No history found for this car.");
    }
  }
}

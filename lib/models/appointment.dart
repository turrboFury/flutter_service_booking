import 'package:flutter_service_booking/models/car.dart';
import 'package:flutter_service_booking/models/database.dart';

class Appointment {
  final Car car;
  final String description;
  final DateTime date;
  late int money;

  Appointment({
    required this.car,
    required this.description,
    required this.date,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_service_booking/models/appoiment_history.dart';
import 'package:flutter_service_booking/models/car.dart';
import 'package:flutter_service_booking/models/database.dart';

class Appointment {
  final Car car;
  final String description;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  late int money;

  Appointment({
    required this.car,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}

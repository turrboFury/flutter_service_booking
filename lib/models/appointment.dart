class Appointment {
  final String licensePlate;
  final String brandModel;
  final int year;
  final int mileage;
  final String fuelType;
  final String description;
  final DateTime date;

  Appointment({
    required this.licensePlate,
    required this.brandModel,
    required this.year,
    required this.mileage,
    required this.fuelType,
    required this.description,
    required this.date,
  });
}

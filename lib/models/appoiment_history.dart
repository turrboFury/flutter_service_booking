import 'package:flutter_service_booking/models/appointment.dart';
import 'package:flutter_service_booking/models/car.dart';

class AppointmentHistory extends Car {
  late List<Appointment> appointments;

  AppointmentHistory({required super.vin})
    : super(
        licensePlate: '',
        brandModel: '',
        year: 0,
        mileage: 0,
        fuelType: '',
      ) {
    appointments =
        []; // Inițializare cu listă goală sau se poate popula din DB.
  }

  void addAppointment(Appointment appointment) {
    appointments.add(appointment);
  }
}

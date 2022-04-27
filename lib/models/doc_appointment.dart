import 'package:doctor_appointment/models/appointment_model.dart';
import 'package:doctor_appointment/models/doctor_model.dart';

class DoctorAppointment {
  final Doctor doctorDetails;
  final Appointment appoDetails;
  DoctorAppointment({
    required this.doctorDetails,
    required this.appoDetails,
  });
}

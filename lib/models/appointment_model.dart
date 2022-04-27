import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final DateTime date;
  final String time;
  final String patientId;
  final String doctorId;
  final String bookingId;
  final String gender;
  final String name;
  final String phoneNumber;
  final String age;
  final String problem;
  final String payment;
  final String photoUrl;
  final String scheduleID;
  final double rating;
  final String review;
  Appointment({
    required this.date,
    required this.time,
    required this.patientId,
    required this.doctorId,
    required this.bookingId,
    required this.gender,
    required this.name,
    required this.phoneNumber,
    required this.age,
    required this.problem,
    required this.payment,
    required this.photoUrl,
    required this.scheduleID,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
      'patientId': patientId,
      'doctorId': doctorId,
      'bookingId': bookingId,
      'gender': gender,
      'name': name,
      'phoneNumber': phoneNumber,
      'age': age,
      'problem': problem,
      'payment': payment,
      'photoUrl': photoUrl,
      'scheduleID': scheduleID,
      'rating': rating,
      'review': review,
    };
  }

  factory Appointment.fromMap(dynamic map) {
    return Appointment(
      date: (map['date'] as Timestamp).toDate(),
      time: map['time'] ?? '',
      patientId: map['patientId'] ?? '',
      doctorId: map['doctorId'] ?? '',
      bookingId: map['bookingId'] ?? '',
      gender: map['gender'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      age: map['age'] ?? '',
      problem: map['problem'] ?? '',
      payment: map['payment'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      scheduleID: map['scheduleID'] ?? '',
      rating: map['rating'] ?? 0,
      review: map['review'] ?? '',
    );
  }
}

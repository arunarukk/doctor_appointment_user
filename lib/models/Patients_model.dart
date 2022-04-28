import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Patients {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String phoneNumber;
  final String age;
  final String gender;
  final String fcmToken;

  const Patients({
    required this.userName,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.fcmToken,
  });

  // static Patients fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;

  //   return Patients(
  //     userName: snapshot["userName"],
  //     uid: snapshot["uid"],
  //     email: snapshot["email"],
  //     photoUrl: snapshot["photoUrl"],
  //     phoneNumber: snapshot["phoneNumber"],
  //     age: snapshot["age"],
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'age': age,
      'gender': gender,
      'fcmToken': fcmToken,
    };
  }

  static Patients fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Patients(
      email: snap['email'] ?? '',
      uid: snap['uid'] ?? '',
      photoUrl: snap['photoUrl'] ?? '',
      userName: snap['userName'] ?? '',
      phoneNumber: snap['phoneNumber'] ?? '',
      age: snap['age'] ?? '',
      gender: snap['gender'] ?? '',
      fcmToken: snap['fcmToken'] ?? '',
    );
  }

  String toMap() => json.encode(toJson());

  factory Patients.fromJson(String source) =>
      Patients.fromJson(json.decode(source));
}

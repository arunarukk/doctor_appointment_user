import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String phoneNumber;
  final Map<String, dynamic> speciality;
  final String about;
  final String experience;
  final double rating;
  final int patients;
  final String qualifications;
  final String address;

  const Doctor({
    required this.userName,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.phoneNumber,
    required this.speciality,
    required this.about,
    required this.experience,
    required this.rating,
    required this.patients,
    required this.qualifications,
    required this.address,
  });

  
  Map<String, dynamic> toJson() => {
        "userName": userName,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "speciality": speciality,
        "about": about,
        "experience": experience,
        "rating": rating,
        "patients": patients,
        "qualifications": qualifications,
        "address": address,
      };

  static Doctor fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return Doctor(
      userName: snap['userName'],
      uid: snap['uid'],
      photoUrl: snap['photoUrl'],
      email: snap['email'],
      phoneNumber: snap['phoneNumber'],
      speciality: snap['speciality'],
      about: snap['about'],
      experience: snap["experience"],
      rating: double.parse(snap['rating'].toString()),
      patients: snap['patients'],
      qualifications: snap['qualifications'],
      address: snap['address'],
    );
  }
}

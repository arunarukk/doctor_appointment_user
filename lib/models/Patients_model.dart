import 'package:cloud_firestore/cloud_firestore.dart';

class Patients {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String phoneNumber;
  final String age;
  final String gender;

  const Patients({
    required this.userName,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.gender,
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

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "age": age,
        "gender": gender,
      };

  static Patients fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return Patients(
      userName: snap['userName'] ?? '',
      uid: snap['uid'] ?? '',
      photoUrl: snap['photoUrl'] ?? '',
      email: snap['email'] ?? '',
      phoneNumber: snap['phoneNumber'] ?? '',
      age: snap['age'] ?? '',
      gender: snap['gender'] ?? '',
    );
  }
}

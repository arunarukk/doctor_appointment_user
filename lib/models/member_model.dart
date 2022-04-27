import 'dart:convert';

class Members {
  final String uid;
  final String photoUrl;
  final String userName;
  final String phoneNumber;
  final String age;
  final String gender;

  Members({
    required this.uid,
    required this.photoUrl,
    required this.userName,
    required this.phoneNumber,
    required this.age,
    required this.gender, 
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'photoUrl': photoUrl,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'age': age,
      'gender':gender,
    };
  }

  factory Members.fromMap(Map<String, dynamic> map) {
    return Members(
      uid: map['uid'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      userName: map['userName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory Members.fromJson(String source) =>
      Members.fromMap(json.decode(source));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

User currentUser = _auth.currentUser!;


Future<List<QueryDocumentSnapshot<Object?>>> getSpeciality() async {
  final snap = await _fireStore.collection('speciality').get();

  final docSnap = snap.docs;
   return docSnap;
}

Future<List<QueryDocumentSnapshot<Object?>>> getListWise(String id) async {
  final snap = await authC.getdoctorDetails();
  List<QueryDocumentSnapshot<Object?>> data = [];
  snap.forEach((element) {
    if (id == element['speciality']['did']) {
      data.add(element);
     }
  });
  return data;
}


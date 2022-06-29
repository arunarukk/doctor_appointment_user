import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/models/appointment_model.dart';
import 'package:doctor_appointment/models/doc_appointment.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import '../models/member_model.dart';
import 'auth_method.dart';

final datacontrol = Get.put(DataController());

class DataController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool? querySelec;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot = [];

  List<DoctorAppointment> appoDocDetails = <DoctorAppointment>[].obs;

  double totalRating = 0;
  int totalPatient = 0;
  DateTimeRange? dateRange;
  String? selectedStartDate;

  String? selectedEndDate;
  QueryDocumentSnapshot<Map<String, dynamic>>? snapshotQuery;
 

  queryData(String queryString) async {
    try {
     
      final data = await _fireStore.collection('doctors').get();
      snapshot = [];
      for (var item in data.docs) {
        if (item
            .data()['userName']
            .toString()
            .toLowerCase()
            .contains(queryString.toLowerCase())) {
       
          snapshot.add(item);
        }
      }
      update(['search']);

      return snapshot;
     } catch (e) {
      debugPrint('queryData error $e');
    }
  }

  querySelection(bool value) {
    querySelec = value;
    }

 
 
//-----------------get details of appointment--------------------------------------------------

  Future<List<DoctorAppointment>> getDetailedAppo() async {
    User currentUser = _auth.currentUser!;

    List<Appointment> appoList = [];
    List<DoctorAppointment> docAppoList = [];
    QuerySnapshot<Map<String, dynamic>> docDetails;

    final appointments = await _fireStore
        .collection('appointment')
        .where('patientId', isEqualTo: currentUser.uid)
        .get();
     for (var element in appointments.docs) {
      appoList.add(Appointment.fromMap(element));
    }
    for (var elu in appoList) {
      docDetails = await _fireStore
          .collection('doctors')
          .where('uid', isEqualTo: elu.doctorId)
          .get();

      for (var value in docDetails.docs) {
        docAppoList.add(DoctorAppointment(
            doctorDetails: Doctor.fromSnapshot(value), appoDetails: elu));
      }
    }
    appoDocDetails.addAll(docAppoList);
    update();
    return docAppoList;
  }

  //============================get upcoming appointment======================

  Future<List<DoctorAppointment>> getUpcomingApp() async {
    User currentUser = _auth.currentUser!;

    final now = DateTime.now();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> upComing = [];
    List<Appointment> appoList = [];
    List<DoctorAppointment> docAppoList = [];
    QuerySnapshot<Map<String, dynamic>> docDetails;
    final appointments = await _fireStore
        .collection('appointment')
        .where('patientId', isEqualTo: currentUser.uid)
        .get();
    for (var item in appointments.docs) {
      final date = (item.data()['date'] as Timestamp).toDate();
       if (now.millisecondsSinceEpoch <= date.millisecondsSinceEpoch) {
       upComing.add(item);
      }
    }

     for (var element in upComing) {
      appoList.add(Appointment.fromMap(element));
    }
    for (var elu in appoList) {
      docDetails = await _fireStore
          .collection('doctors')
          .where('uid', isEqualTo: elu.doctorId)
          .get();
      for (var value in docDetails.docs) {
        docAppoList.add(DoctorAppointment(
            doctorDetails: Doctor.fromSnapshot(value), appoDetails: elu));
      }
    }
    appoDocDetails.addAll(docAppoList);
    return docAppoList;
  }

  //============================get past appointment======================

  Future<List<DoctorAppointment>> getPastApp() async {
    User currentUser = _auth.currentUser!;

   
    final now = DateTime.now();
   
    List<QueryDocumentSnapshot<Map<String, dynamic>>> past = [];
    List<Appointment> appoList = [];
    List<DoctorAppointment> docAppoList = [];
    QuerySnapshot<Map<String, dynamic>> docDetails;
    final appointments = await _fireStore
        .collection('appointment')
        .where('patientId', isEqualTo: currentUser.uid)
        .get();

    for (var item in appointments.docs) {
      final date = (item.data()['date'] as Timestamp).toDate();
       if (now.millisecondsSinceEpoch >= date.millisecondsSinceEpoch) {
     
        past.add(item);
      }
    }

    for (var element in past) {
      appoList.add(Appointment.fromMap(element));
    }
    for (var elu in appoList) {
      docDetails = await _fireStore
          .collection('doctors')
          .where('uid', isEqualTo: elu.doctorId)
          .get();

      for (var value in docDetails.docs) {
        docAppoList.add(DoctorAppointment(
            doctorDetails: Doctor.fromSnapshot(value), appoDetails: elu));
      }
    }
    appoDocDetails.addAll(docAppoList);
    update();
    return docAppoList;
  }

  // get members==============================================================

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getMembers() async* {
    User currentUser = _auth.currentUser!;
    final memberDetails = await _fireStore
        .collection('members')
        .where('uid', isEqualTo: currentUser.uid)
        .get();
    // print(memberDetails.docs.first.data());
    yield memberDetails.docs;
  }

  // get scheduled time=======================================================

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getScheduleDetails(
      String doctorId) async {
    DateTime today = DateTime.now();
    final scheduleDetails = await _fireStore
        .collection('doctors')
        .doc(doctorId)
        .collection('schedule')
        .where('date', isGreaterThan: today)
        .get();
    final scheduleData = scheduleDetails.docs;
    return scheduleData;
  }

  addRatingAndReview(
      {required String docID,
      required String review,
      required double rating}) async {
    final appointment =
        await _fireStore.collection('appointment').doc(docID).get();
  
    final data = appointment.data();

  
    await _fireStore.collection('appointment').doc(docID).update(Appointment(
            date: (data!['date'] as Timestamp).toDate(),
            time: data['time'],
            patientId: data['patientId'],
            doctorId: data['doctorId'],
            bookingId: data['bookingId'],
            gender: data['gender'],
            name: data['name'],
            phoneNumber: data['phoneNumber'],
            age: data['age'],
            problem: data['problem'],
            payment: data['payment'],
            photoUrl: data['photoUrl'],
            scheduleID: data['scheduleID'],
            rating: rating,
            review: review,
            status: '')
        .toMap());
    update(['rating']);
  }

  getRatingAndReview({required String doctorID}) async {
    final appointment = await _fireStore
        .collection('appointment')
        .where('doctorId', isEqualTo: doctorID)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data;

    data = appointment.docs;
    double totRating = 0;
   
    int totalCount = 0;
    int five = 0, four = 0, three = 0, two = 0, one = 0;

    data.forEach((element) {
      if (element.data()['rating'] != 0) {
        totRating = totRating + element.data()['rating'];

        totalCount++;
        if (element.data()['rating'] == 5) {
          five++;
        }
        if (element.data()['rating'] == 4) {
          four++;
        }
        if (element.data()['rating'] == 3) {
          three++;
        }
        if (element.data()['rating'] == 2) {
          two++;
        }
        if (element.data()['rating'] == 1) {
          one++;
        }
      }
      totRating = totRating + element.data()['rating'];
    });

    totalPatient = appointment.docs.length;
    totalRating =
        (5 * five + 4 * four + 3 * three + 2 * two + 1 * one) / (totalCount);
    update(['rating']);
  }

  // ====================== filter DateRange ===================================

  Future<List<DoctorAppointment>> filterDateRange() async {
    List<DoctorAppointment> pastAppo = await getPastApp();
    List<DoctorAppointment> filteredData = [];
    final startDate = dateRange!.start.millisecondsSinceEpoch;
    final endDate = dateRange!.end.millisecondsSinceEpoch;

    for (var item in pastAppo) {
      final date = item.appoDetails.date.millisecondsSinceEpoch;
   
      if (startDate <= date && endDate >= date) {
        filteredData.add(item);
      }
    }

    return filteredData;
  }

  // ============= past and filter =====================================

  Future<List<DoctorAppointment>> pastRefresh() async {
    if (dateRange == null) {
      return await getPastApp();
    }
     return await filterDateRange();
  }

  // -------------------- add members---------------------------------

  addMembers({
    required String userName,
    required String phoneNumber,
    required Uint8List photoUrl,
    required String age,
    required String gender,
    required String title,
  }) async {
    final String memberId = const Uuid().v1();
    User currentUser = _auth.currentUser!;

  
    String imageUrl = await StorageMethods()
        .uploadImageToStorage('memberProfile', photoUrl, false, memberId);

    Members members = Members(
      uid: currentUser.uid,
      photoUrl: imageUrl,
      userName: userName,
      phoneNumber: phoneNumber,
      age: age,
      gender: gender,
    );

    await _fireStore.collection('members').doc(memberId).set(
          members.toMap(),
        );
    update(['member']);
  }

  updateMember(
      {required String userName,
      required String phoneNumber,
      required String photoUrl,
      required String age,
      required String gender,
      required String title,
      required String memId}) async {
    User currentUser = _auth.currentUser!;

    Members members = Members(
      uid: currentUser.uid,
      photoUrl: photoUrl,
      userName: userName,
      phoneNumber: phoneNumber,
      age: age,
      gender: gender,
    );

    await _fireStore.collection('members').doc(memId).update(members.toMap());
    update(['member']);
  }

  deleteMember(String memId) async {
    final memberDetails =
        await _fireStore.collection('members').doc(memId).delete();
    update(['member']);
  }

  docotrDetails({required String doctorId}) async {
    final docotrs = await _fireStore.collection('doctors').doc(doctorId).get();
    final fcmToken = docotrs.data()!['fcmToken'];
    final patient = await AuthMethods().getUserDetails();
    final name = patient.userName.capitalize;

    notifyC.sendChatPushMessage('You have new Message', '$name', fcmToken);
  }
}

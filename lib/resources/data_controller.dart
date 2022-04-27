import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/models/appointment_model.dart';
import 'package:doctor_appointment/models/doc_appointment.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final datacontrol = Get.put(DataController());

class DataController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool? querySelec;
  QuerySnapshot<Map<String, dynamic>>? snapshot;

  List<DoctorAppointment> appoDocDetails = <DoctorAppointment>[].obs;

  double totalRating = 0;
  int totalPatient = 0;
  DateTimeRange? dateRange;
  String? selectedStartDate;

  String? selectedEndDate;

  Future queryData(String queryString) async {
    try {
      // List<QuerySnapshot<Map<String, dynamic>>>? queryList;

      final data = await _fireStore
          .collection('doctors')
          .where('userName', isGreaterThanOrEqualTo: queryString)
          .where('userName', isLessThanOrEqualTo: '$queryString\uf7ff')
          .get();

      //print(data.toString());
      snapshot = data;
      update();
      //print(data);
    } catch (e) {
      print('queryData error $e');
    }
  }

  querySelection(bool value) {
    querySelec = value;
    update();
  }

  //  appointment details ============================

  // Future<List<DoctorAppointment>> getAppointmentDetails() async {
  //   User currentUser = _auth.currentUser!;

  //   List<Appointment> appoList = [];
  //   List<DoctorAppointment> docAppoList = [];

  //   appoDocDetails = [];

  //   final appointments = await _fireStore
  //       .collection('appointment')
  //       .where('patientId', isEqualTo: currentUser.uid)
  //       .get();
  //   // print(appointments.docs.first.data());
  //   print(appointments.docs);
  //   appointments.docs.forEach((element) {
  //     appoList.add(Appointment.fromMap(element));
  //   });
  //   print(appoList);
  //   //print('appolist 121  ${appoList.length}');
  //   //int count = 1;
  //   appoList.forEach((element1) async {
  //     // print("121 count  $count ");
  //     // count++;
  //     print(element1);
  //     final docDetails = await _fireStore
  //         .collection('doctors')
  //         .where('uid', isEqualTo: element1.doctorId)
  //         .get();
  //     print(docDetails.docs.first);
  //     //
  //     //getting doctor
  //     // print('docDetials 121 ${docDetails.docs.length}');
  //     docDetails.docs.forEach((element) {
  //       docAppoList.add(DoctorAppointment(
  //           doctorDetails: Doctor.fromSnapshot(element),
  //           appoDetails: element1));
  //     });
  //     //
  //     // appoDocDetails.addAll(docAppoList);
  //     // update();
  //     // print('docAppoList${docAppoList.length}');
  //   });

  //   //  print(appoDocDetails);
  //   return appoDocDetails;
  // }

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
    // print('appo');
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
        print(docAppoList);
      }
    }
    appoDocDetails.addAll(docAppoList);
    update();
    return docAppoList;
  }

  //============================get upcoming appointment======================

  Future<List<DoctorAppointment>> getUpcomingApp() async {
    User currentUser = _auth.currentUser!;

    //final allAppoinment = getDetailedAppo();

    final now = DateTime.now();
    final week = DateTime(now.year, now.month, now.day + 1);

    List<QueryDocumentSnapshot<Map<String, dynamic>>> upComing = [];
    List<Appointment> appoList = [];
    List<DoctorAppointment> docAppoList = [];
    QuerySnapshot<Map<String, dynamic>> docDetails;
    print('upcoming');
    final appointments = await _fireStore
        .collection('appointment')
        .where('patientId', isEqualTo: currentUser.uid)
        .get();

    for (var item in appointments.docs) {
      final date = (item.data()['date'] as Timestamp).toDate();
      //print('------22 ${date.millisecondsSinceEpoch}');
      if (now.millisecondsSinceEpoch <= date.millisecondsSinceEpoch) {
        // print('------1111 ${date.millisecondsSinceEpoch}');
        // print(week.millisecondsSinceEpoch);
        // print(item);
        upComing.add(item);
      }
    }

    //print(appointments.docs.length);

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
        // print(docAppoList);
      }
    }
    appoDocDetails.addAll(docAppoList);
    update();
    // print('-----3333 ${docAppoList}');
    return docAppoList;
  }

  //============================get past appointment======================

  Future<List<DoctorAppointment>> getPastApp() async {
    User currentUser = _auth.currentUser!;

    //final allAppoinment = getDetailedAppo();

    final now = DateTime.now();
    final week = DateTime(now.year, now.month, now.day + 1);

    List<QueryDocumentSnapshot<Map<String, dynamic>>> past = [];
    List<Appointment> appoList = [];
    List<DoctorAppointment> docAppoList = [];
    QuerySnapshot<Map<String, dynamic>> docDetails;
    print('past');
    final appointments = await _fireStore
        .collection('appointment')
        .where('patientId', isEqualTo: currentUser.uid)
        .get();

    for (var item in appointments.docs) {
      final date = (item.data()['date'] as Timestamp).toDate();
      //print('------22 ${date.millisecondsSinceEpoch}');
      if (now.millisecondsSinceEpoch >= date.millisecondsSinceEpoch) {
        // print('------1111 ${date.millisecondsSinceEpoch}');
        // print(week.millisecondsSinceEpoch);
        // print(item);
        past.add(item);
      }
    }

    //print(appointments.docs.length);

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
        // print(docAppoList);
      }
    }
    appoDocDetails.addAll(docAppoList);
    update();
    // print('-----3333 ${docAppoList}');
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
    print(scheduleData);
    return scheduleData;
  }

  addRatingAndReview(
      {required String docID,
      required String review,
      required double rating}) async {
    final appointment =
        await _fireStore.collection('appointment').doc(docID).get();
    print(appointment.data());

    final data = appointment.data();

    // print(data!['name']);
    // print(data['date']);
    // print(data['payment']);
    // print(data['age']);
    // print(data['scheduleID']);
    // print(data['gender']);
    // print(data['patientId']);
    // print(data['bookingId']);
    // print(data['photoUrl']);
    // print(data['problem']);
    // print(data['phoneNumber']);
    // print(data['doctorId']);

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
        ).toMap());
  }

  getRatingAndReview({required String doctorID}) async {
    final appointment = await _fireStore
        .collection('appointment')
        .where('doctorId', isEqualTo: doctorID)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data;

    data = appointment.docs;
    double totRating = 0;
    double total = 0;

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
      // print(dateRange!.start);

      if (startDate <= date && endDate >= date) {
        filteredData.add(item);
      }
    }

    print(filteredData);
    return filteredData;
  }

  // ============= past and filter =====================================

  Future<List<DoctorAppointment>> pastRefresh() async {
    if (dateRange == null) {
      // update();
      return await getPastApp();
    }
    //update();
    return await filterDateRange();
  }
}

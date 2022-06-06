import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/models/appointment_model.dart';
import 'package:doctor_appointment/models/schedule.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/resources/specialty_mathod.dart';
import 'package:doctor_appointment/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../get_controller/get_controller.dart';

enum User1 { doctor, patient }

class AuthMethods {
  // final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);

  bool codeSent = false;
  late String verId;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<Patients> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _fireStore.collection('patients').doc(currentUser.uid).get();

    return Patients.fromSnapshot(snapshot);
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getdoctorDetails() async {
    // User currentUser = _auth.currentUser!;
    QuerySnapshot snapshot = await _fireStore.collection('doctors').get();

    List<QueryDocumentSnapshot<Object?>> docSnap = snapshot.docs;

    // print(docSnap[1].data());

    //return Patients.fromSnapshot(snapshot);
    return docSnap;
  }

  getFcmToken(String uid, String userType) async {
    final userData =
        await FirebaseFirestore.instance.collection(userType).doc(uid).get();
    final fcmToken = userData.data()!['fcmToken'];
    return fcmToken;
  }

  Future<void> updateUser({
    required String email,
    // required String password,
    required String userName,
    required String phoneNumber,
    required String photoUrl,
    //required Uint8List file,
    required String age,
    required String gender,
  }) async {
    try {
      dynamic test;
      final currentUser = getUserDetails();
      // if (currentUser==null) {

      // String photoUrl = await StorageMethods()
      //     .uploadImageToStorage('profilePics', file, false);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      currentUser.then((value) async {
        Patients patients = Patients(
          userName: userName,
          uid: value.uid,
          photoUrl: photoUrl,
          email: email,
          phoneNumber: phoneNumber,
          age: age,
          gender: gender,
          fcmToken: fcmToken!,
        );
        await _fireStore
            .collection('patients')
            .doc(value.uid)
            .update(patients.toJson());
        test = value;
        statecontrol.update(['profile']);
        // print(test);
      });
      print(test);
      //}

    } catch (e) {
      print('=============================' + e.toString());
    }
  }
  // ====================== set otp user ================================

  addOtpSignUser(Patients patients) async {
    await _fireStore
        .collection('patients')
        .doc(currentUser.uid)
        .set(patients.toJson());
  }

  //sign up Patient

  Future<String> signUpPatient({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String? token = await FirebaseMessaging.instance.getToken();
    String result = 'Something went wrong';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          phoneNumber.isNotEmpty) {
        // register Patients

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage(
            'profilePics', file, false, _auth.currentUser!.uid);

        // add patients to database

        Patients patients = Patients(
          userName: userName,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          phoneNumber: phoneNumber,
          age: '',
          gender: '',
          fcmToken: token!,
        );

        _fireStore
            .collection('patients')
            .doc(cred.user!.uid)
            .set(patients.toJson());
        result = 'Success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        result = 'The email is badly formatted.';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

//=====================sign up with phone number ============

  otpSingUp({
    required String email,
    required String uid,
    required String userName,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String result = 'Something went wrong';
    try {
      if (email.isNotEmpty || userName.isNotEmpty || phoneNumber.isNotEmpty) {
        // print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false, uid);

        // add doctor to database

        // Doctor doctor = Doctor(
        //   userName: userName,
        //   uid: uid,
        //   photoUrl: photoUrl,
        //   email: email,
        //   phoneNumber: phoneNumber,
        //   speciality: {},
        //   about: '',
        //   experience: '',
        //   rating: 0,
        //   patients: 0,
        // );

        final fcmToken = await FirebaseMessaging.instance.getToken();

        Patients patients = Patients(
          userName: userName,
          uid: uid,
          photoUrl: photoUrl,
          email: email,
          phoneNumber: phoneNumber,
          age: '',
          gender: '',
          fcmToken: fcmToken!,
        );

        _fireStore.collection('patients').doc(uid).set(patients.toJson());
        result = 'Success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-phone number') {
        result = 'The phone number is badly formatted.';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  // logging in user

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Something went wrong.';
    print(email);
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'Success';
      } else {
        result = 'please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'wrong-password') {
        result = 'Wrong password';
      } else if (err.code == 'user-not-found') {
        result = 'Wrong Email';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

// ============================ phone verification=================================

  verifyPhone({required phoneNumber, required BuildContext context}) async {
    String result = 'Something went wrong.';
    try {
      if (phoneNumber.isNotEmpty) {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential).then((value) {
              print("You are logged in successfully");
            });
            final snackBar = SnackBar(content: Text('Login Success'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          verificationFailed: (FirebaseAuthException e) {
            final snackBar = SnackBar(content: Text(e.message!));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          codeSent: (String verificationId, int? resendToken) {
            codeSent = true;
            verId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verId = verificationId;
          },
          timeout: Duration(seconds: 60),
        );
        result = 'Success';
      } else {
        result = 'please enter all the fields';
      }
    } catch (e) {
      print('phone Verification error $e');
    }
  }

  // verify otp================================================================
  verifyOtp(String pin, BuildContext context) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);

    try {
      await _auth.signInWithCredential(credential);
      final snackBar = SnackBar(content: Text('Login Success'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // ===================== signOut user =================================

  Future<void> signOut() async {
    
    await _auth.signOut();
  }

  // ===================== booking appointment ==========================

  bookAppoint({
    required name,
    required patientId,
    required doctorId,
    required gender,
    required DateTime date,
    required phoneNumber,
    required age,
    required problem,
    required payment,
    required time,
    required photoUrl,
    required dateID,
  }) async {
    // print('photo $photoUrl');
    final String bookingId = Uuid().v1();
    //print('book payment auth');
    Appointment appointment = Appointment(
      name: name,
      patientId: patientId,
      doctorId: doctorId,
      gender: gender,
      date: date,
      phoneNumber: phoneNumber,
      age: age,
      bookingId: bookingId,
      problem: problem,
      payment: payment,
      time: time,
      photoUrl: photoUrl,
      scheduleID: dateID,
      rating: 0.0,
      review: '',
      status: '',
    );

    // =============== adding to the patient list===========================
    final docFcm = await getFcmToken(doctorId, "doctors");
    notifyC.sendPushMessage(
        "you have a new appointment", "${name + " " + time}", docFcm);
    await _fireStore
        .collection('appointment')
        .doc(bookingId)
        .set(appointment.toMap());

    //================ update doctor schedule===========================

    final dateData = await _fireStore
        .collection('doctors')
        .doc(doctorId)
        .collection('schedule')
        .doc(dateID)
        .get();
    print(time);
    print(date);
    final appoTimeData = dateData.data();

    updateDoctorSchedule(
        doctorId: doctorId,
        documentId: dateID,
        schedule: Schedule(
          date: date,
          elevenAm: time == '11:00 AM' ? false : appoTimeData!['elevenAm'],
          fivePm: time == '5:00 PM' ? false : appoTimeData!['fivePm'],
          fourPm: time == '4:00 PM' ? false : appoTimeData!['fourPm'],
          nineAm: time == '9:00 AM' ? false : appoTimeData!['nineAm'],
          onepm: time == '1:00 PM' ? false : appoTimeData!['onepm'],
          sixPm: time == '6:00 PM' ? false : appoTimeData!['sixPm'],
          tenAm: time == '10:00 AM' ? false : appoTimeData!['tenAm'],
          threePm: time == '3:00 PM' ? false : appoTimeData!['threePm'],
          twelvePm: time == '12:00 PM' ? false : appoTimeData!['twelvePm'],
          twoPm: time == '2:00 PM' ? false : appoTimeData!['twoPm'],
        ),
        time: time);
    await _fireStore
        .collection('doctors')
        .doc(doctorId)
        .collection('schedule')
        .doc(dateID)
        .collection('time')
        .add({'time': time});
  }

  // ================= update doctor schedule===================================

  updateDoctorSchedule(
      {required String doctorId,
      required String documentId,
      required Schedule schedule,
      required String time}) async {
    await _fireStore
        .collection('doctors')
        .doc(doctorId)
        .collection('schedule')
        .doc(documentId)
        .update(schedule.toMap());
  }

  //====================== cancel appointment ================================

  cancelAppoin({
    required String appoID,
    required String time,
    required DateTime date,
    required String docID,
    required String scheduleID,
    required String name,
  }) async {
    //User currentUser = _auth.currentUser!;
    final dateData = await _fireStore
        .collection('doctors')
        .doc(docID)
        .collection('schedule')
        .doc(scheduleID)
        .get();
    print(time);
    print(date);
    final appoTimeData = dateData.data();

    updateDoctorSchedule(
        time: time,
        doctorId: docID,
        documentId: scheduleID,
        schedule: Schedule(
          date: date,
          elevenAm: time == '11:00 AM' ? true : appoTimeData!['elevenAm'],
          fivePm: time == '5:00 PM' ? true : appoTimeData!['fivePm'],
          fourPm: time == '4:00 PM' ? true : appoTimeData!['fourPm'],
          nineAm: time == '9:00 AM' ? true : appoTimeData!['nineAm'],
          onepm: time == '1:00 PM' ? true : appoTimeData!['onepm'],
          sixPm: time == '6:00 PM' ? true : appoTimeData!['sixPm'],
          tenAm: time == '10:00 AM' ? true : appoTimeData!['tenAm'],
          threePm: time == '3:00 PM' ? true : appoTimeData!['threePm'],
          twelvePm: time == '12:00 PM' ? true : appoTimeData!['twelvePm'],
          twoPm: time == '2:00 PM' ? true : appoTimeData!['twoPm'],
        ));

    await _fireStore
        .collection('appointment')
        .doc(appoID)
        .update({'status': 'canceled'});

    final dateTime = await _fireStore
        .collection('doctors')
        .doc(docID)
        .collection('schedule')
        .doc(scheduleID)
        .collection('time')
        .where('time', isEqualTo: time)
        .get();

    final timeId = dateTime.docs.first.id;

    await _fireStore
        .collection('doctors')
        .doc(docID)
        .collection('schedule')
        .doc(scheduleID)
        .collection('time')
        .doc(timeId)
        .delete();
    datacontrol.update(['appointment']);
    final docFcm = await getFcmToken(docID, "doctors");
    notifyC.sendPushMessage("Appointment canceled", name + " " + time, docFcm);

    print(timeId);
  }
}

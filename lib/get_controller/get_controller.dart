import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import '../models/appointment_model.dart';
import '../models/schedule.dart';

final statecontrol = Get.put(StateController());

class StateController extends GetxController {
  Patients? user;

  var startPosition;
  var selectedChipIndex;
  var isMoreDetail;
  dynamic dropDateValue;

  DateTime? selectedDate;

  bool selectedeValue = false;
  bool dateTrue = false;

  var current;
  var currentDate;
  var memberSel = -1;

  var selectionMember;

  dynamic dropvalue;

  dynamic dropDate;

  bool passwordVisible = true;

  String selectedGender = 'male';

  bool nine = false;
  bool ten = false;
  bool eleven = false;
  bool twel = false;
  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  bool six = false;

  final AuthMethods _authMethods = AuthMethods();

  // Patients get getUser => _user!;

  String? selectedStartDate;

  String? selectedEndDate;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<Patients> getUserProfileDetails() async* {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _fireStore.collection('patients').doc(currentUser.uid).get();

    yield Patients.fromSnapshot(snapshot);
  }

  dateRange(DateTimeRange? dateRange) {
    selectedStartDate = DateFormat('MMM-dd').format(dateRange!.start);
    selectedEndDate = DateFormat('MMM-dd').format(dateRange.end);
    update(['filter']);
  }

  Future<void> refreshUser() async {
    Patients _user = await _authMethods.getUserDetails();
    user = _user;
    update();
  }

  void starAnimation(var startPos) {
    startPosition = startPos;
    update();
  }

  void selectedIndex(var index) {
    selectedChipIndex = index;
    update();
  }

  void isMoreDetailActive(bool more) {
    isMoreDetail = more;
    update();
  }

  void dropDownChange(String newValue) {
    dropvalue = newValue;
    update();
  }

  void dropDownDate(String newValue) {
    dropDate = newValue;
    update();
  }

  void onGenderSelected(String genderKey) {
    selectedGender = genderKey;
    update(['gender']);
  }
}

final signControl = Get.put(SignController());

class SignController extends GetxController {
  Uint8List?        image;
  Uint8List? memiImage;
  bool? isLoading;
  bool loadL = false;
  bool otpCodeVisible = false;
  bool otpLogin = false;
  void imageUpdate(Uint8List img) {
    image = img;
    update();
  }

  void loading(bool load) {
    isLoading = load;
    //update();
  }
}

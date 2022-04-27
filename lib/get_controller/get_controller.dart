import 'dart:typed_data';

import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
}

class SignController extends GetxController {
  Uint8List? image;
  Uint8List? memiImage;
  bool? isLoading;
  void imageUpdate(Uint8List img) {
    image = img;
    update();
  }

  void loading(bool load) {
    isLoading = load;
    update();
  }
}

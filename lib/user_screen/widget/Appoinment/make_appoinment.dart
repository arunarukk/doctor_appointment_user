import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/payment_screen.dart';
import 'package:doctor_appointment/user_screen/widget/Appoinment/problem_screen.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/utility_method.dart';

class MakeAppoinment extends StatelessWidget {
  MakeAppoinment({Key? key, required this.docId}) : super(key: key);
  final String docId;

  // final TextEditingController nameController = TextEditingController();

  final TextEditingController disController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  DateTime? _selectedDate;

  //String dropdownValue = 'Binil';
  String? name;

  String? phone;

  String? age;

  String? photo;

  String? gender;

  bool timeSelected = false;

  // static final Map<String, String> genderMap = {
  final control = Get.put(StateController());

  // String _selectedGender = genderMap.keys.first;
  DateTime? selectedDate;

  bool selectedTime = false;

  String? dateID;

  @override
  Widget build(BuildContext context) {
    print('widget');

    statecontrol.currentDate = 0;
    statecontrol.dropDateValue = null;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final date = DateFormat('dd/MM/yyyy').format(tomorrow);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Make Appoinment',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: kBlack,
            )),
      ),
      body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasData && snapshot.data != ConnectivityResult.none) {
              return FutureBuilder<
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                future: datacontrol.getScheduleDetails(docId),
                builder: (context, schduledata) {
                  // print('schedule${schduledata.data}');
                  print('helllo');
                  bool nineAm = false;
                  bool tenAm = false;
                  bool elevenAm = false;
                  bool twelvePm = false;
                  bool onePm = false;
                  bool twoPm = false;
                  bool threePm = false;
                  bool fourPm = false;
                  bool fivePm = false;
                  bool sixPm = false;

                  if (schduledata.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (schduledata.data != null) {
                    if (schduledata.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/no appointment.png',
                              scale: .8,
                            ),
                            Text('No Appointments!'),
                          ],
                        ),
                      );
                    }
                    _selectedDate =
                        (schduledata.data![0]['date'] as Timestamp).toDate();
                    dateID = schduledata.data![0].id;
                    statecontrol.dropDateValue = schduledata.data![0].data();
                  }

                  return schduledata.data == null
                      ? Center(
                          child: Text('No appointments'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100.w,
                                height: 10.h,
                                // color: kBlue,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: schduledata.data!.length,
                                    itemBuilder: ((context, index) {
                                      DateTime date = (schduledata.data![index]
                                              ['date'] as Timestamp)
                                          .toDate();

                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GetBuilder<StateController>(
                                            init: StateController(),
                                            id: 'datecontrol',
                                            builder: (statecontrol) {
                                              return InkWell(
                                                onTap: () {
                                                  selectedDate = date;
                                                  dateID = schduledata
                                                      .data![index].id;

                                                  statecontrol.currentDate =
                                                      index;
                                                  statecontrol.dropDateValue =
                                                      schduledata.data![index]
                                                          .data();
                                                  _selectedDate = (schduledata
                                                              .data![index]
                                                          ['date'] as Timestamp)
                                                      .toDate();

                                                  statecontrol
                                                      .update(['datecontrol']);
                                                  statecontrol
                                                      .update(['timecontrol']);
                                                },
                                                child: Container(
                                                    height: 4.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        color: statecontrol
                                                                    .currentDate ==
                                                                index
                                                            ? kBlue
                                                            : kWhite,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                            color: kBlue,
                                                            width: 1)),
                                                    child: Center(
                                                      child: Text(
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(date),
                                                        style: TextStyle(
                                                          color: statecontrol
                                                                      .currentDate ==
                                                                  index
                                                              ? kWhite
                                                              : kBlack,
                                                        ),
                                                      ),
                                                    )),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       left: 10.0, right: 10),
                              //   child: Container(
                              //     // color: kBlue,
                              //     height: size * .24,
                              //     width: size * 1,
                              //     child: Column(
                              //       children: [
                              //         Padding(
                              //           padding: const EdgeInsets.only(
                              //               left: 40.0,
                              //               right: 40,
                              //               top: 15,
                              //               bottom: 15),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceEvenly,
                              //             children: [
                              //               appoinmentTime(
                              //                   nineAm, size, '9:00 AM'),
                              //               appoinmentTime(
                              //                   tenAm, size, '10:00 Am'),
                              //               appoinmentTime(
                              //                   elevenAm, size, '11:00 AM'),
                              //             ],
                              //           ),
                              //         ),
                              //         Padding(
                              //           padding: const EdgeInsets.only(
                              //               left: 6.0,
                              //               right: 6,
                              //               top: 15,
                              //               bottom: 15),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceEvenly,
                              //             children: [
                              //               appoinmentTime(
                              //                   twelvePm, size, '12:00 PM'),
                              //               appoinmentTime(
                              //                   onePm, size, '1:00 PM'),
                              //               appoinmentTime(
                              //                   twoPm, size, '2:00 PM'),
                              //               appoinmentTime(
                              //                   threePm, size, '3:00 PM'),
                              //             ],
                              //           ),
                              //         ),
                              //         Padding(
                              //           padding: const EdgeInsets.only(
                              //               left: 40.0,
                              //               right: 40,
                              //               top: 15,
                              //               bottom: 15),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceEvenly,
                              //             children: [
                              //               appoinmentTime(
                              //                   fourPm, size, '4:00 PM'),
                              //               appoinmentTime(
                              //                   fivePm, size, '5:00 PM'),
                              //               appoinmentTime(
                              //                   sixPm, size, '6:00 PM'),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     const Text(
                              //       'Select date :',
                              //       style: TextStyle(
                              //           fontSize: 18, fontWeight: FontWeight.bold),
                              //     ),
                              //     TextButton.icon(
                              //       onPressed: () async {
                              //         // final _selectedDateTemp = await showDatePicker(
                              //         //   context: context,
                              //         //   initialDate: DateTime.now()
                              //         //       .add(const Duration(days: 1)),
                              //         //   firstDate: DateTime.now()
                              //         //       .add(const Duration(days: 1)),
                              //         //   lastDate: DateTime.now()
                              //         //       .add(const Duration(days: 7)),
                              //         // );
                              //         // if (_selectedDateTemp == null) {
                              //         //   return;
                              //         // } else {
                              //         //   //print(_selectedDateTemp.toString());
                              //         //   setState(() {
                              //         //     _selectedDate = _selectedDateTemp;
                              //         //   });
                              //         // }
                              //         final data=DataController()
                              //             .getScheduleDetails(widget.docId);

                              //       },
                              //       icon: Icon(
                              //         Icons.calendar_today,
                              //         color: kBlue,
                              //       ),
                              //       label: Text(
                              //         _selectedDate == null
                              //             ? date
                              //             : DateFormat('dd/MM/yyyy')
                              //                 .format(_selectedDate!)
                              //         // _selectedDate.toString(),
                              //         ,
                              //         style: TextStyle(color: kBlack),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // date dropdown value =================================Start==========================================================

                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       'Choose date :',
                              //       style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     //kHeight10,
                              //     GetBuilder<StateController>(
                              //       init: StateController(),
                              //       builder: (controller) {
                              //         if (schduledata.connectionState ==
                              //             ConnectionState.waiting) {
                              //           return Center(
                              //             child: CircularProgressIndicator(),
                              //           );
                              //         }
                              //         if (schduledata.data == null) {
                              //           return Center(
                              //             child: Text('Not Available'),
                              //           );
                              //         }
                              //         final allvalue = schduledata.data!;
                              //         return DropdownButton<String>(
                              //             value: controller.dropDate,
                              //             hint: Text('Select Date'),
                              //             items: (allvalue).map((e) {
                              //               return DropdownMenuItem(
                              //                 value: e.id,
                              //                 child: Text(
                              //                     DateFormat('dd/MM/yyyy')
                              //                         .format((e['date']
                              //                                 as Timestamp)
                              //                             .toDate())),
                              //                 onTap: () {
                              //                   timeSelected = false;
                              //                   print(e.data());
                              //                   controller.dropDateValue =
                              //                       e.data();
                              //                   selectedDate =
                              //                       (e['date'] as Timestamp)
                              //                           .toDate();
                              //                   print(selectedDate);
                              //                   controller
                              //                       .update(['timecontrol']);
                              //                 },
                              //               );
                              //             }).toList(),
                              //             onChanged: (selectedValue) {
                              //               controller
                              //                   .dropDownDate(selectedValue!);
                              //             });
                              //       },
                              //     ),
                              //   ],
                              // ),

                              // date dropdown value =================================End==========================================================

                              // kHeight10,
                              GetBuilder<StateController>(
                                  init: StateController(),
                                  id: 'timecontrol',
                                  builder: (controller) {
                                    if (controller.dropDateValue == null) {
                                      return Container();
                                    }
                                    nineAm = controller.dropDateValue['nineAm'];
                                    tenAm = controller.dropDateValue['tenAm'];
                                    elevenAm =
                                        controller.dropDateValue['elevenAm'];
                                    twelvePm =
                                        controller.dropDateValue['twelvePm'];
                                    onePm = controller.dropDateValue['onepm'];
                                    twoPm = controller.dropDateValue['twoPm'];
                                    threePm =
                                        controller.dropDateValue['threePm'];
                                    fourPm = controller.dropDateValue['fourPm'];
                                    fivePm = controller.dropDateValue['fivePm'];
                                    sixPm = controller.dropDateValue['sixPm'];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: Container(
                                            // color: kBlue,
                                            height: 24.h,
                                            width: 100.w,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 40.0,
                                                          right: 40,
                                                          top: 15,
                                                          bottom: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      appoinmentTime(
                                                          nineAm,
                                                          '9:00 AM',
                                                          statecontrol.nine,
                                                          0),
                                                      appoinmentTime(
                                                          tenAm,
                                                          '10:00 Am',
                                                          statecontrol.ten,
                                                          1),
                                                      appoinmentTime(
                                                          elevenAm,
                                                          '11:00 AM',
                                                          statecontrol.eleven,
                                                          2),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0,
                                                          right: 6,
                                                          top: 15,
                                                          bottom: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      appoinmentTime(
                                                          twelvePm,
                                                          '12:00 PM',
                                                          statecontrol.twel,
                                                          3),
                                                      appoinmentTime(
                                                          onePm,
                                                          '1:00 PM',
                                                          statecontrol.one,
                                                          4),
                                                      appoinmentTime(
                                                          twoPm,
                                                          '2:00 PM',
                                                          statecontrol.two,
                                                          5),
                                                      appoinmentTime(
                                                          threePm,
                                                          '3:00 PM',
                                                          statecontrol.three,
                                                          6),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 40.0,
                                                          right: 40,
                                                          top: 15,
                                                          bottom: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      appoinmentTime(
                                                          fourPm,
                                                          '4:00 PM',
                                                          statecontrol.four,
                                                          7),
                                                      appoinmentTime(
                                                          fivePm,
                                                          '5:00 PM',
                                                          statecontrol.five,
                                                          8),
                                                      appoinmentTime(
                                                          sixPm,
                                                          '6:00 PM',
                                                          statecontrol.six,
                                                          9),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              kHeight10,
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    'Choose patient',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  kHeight10,
                                  // GetBuilder<StateController>(
                                  //   init: StateController(),
                                  //   builder: (controller) {
                                  //     return DropdownButton<String>(
                                  //       hint: Text('Select'),
                                  //       value: controller.dropvalue,
                                  //       icon: const Icon(
                                  //         Icons.arrow_drop_down,
                                  //       ),
                                  //       //elevation: 16,
                                  //       style: TextStyle(color: kBlue),
                                  //       underline: Container(
                                  //         height: 2,
                                  //         width: 80,
                                  //         color: kBlue,
                                  //       ),
                                  //       onChanged: (selectedValue) {
                                  //         controller
                                  //             .dropDownChange(selectedValue!);
                                  //       },
                                  //       items: (data).map((e) {
                                  //         return DropdownMenuItem(
                                  //           value: e.id,
                                  //           child: Text(
                                  //             e['userName']
                                  //                 .toString()
                                  //                 .capitalize!,
                                  //           ),
                                  //           onTap: () {
                                  //             print(e.data());
                                  //             dropdownValue =
                                  //                 e.data()['userName'];
                                  //             name = e.data()['userName'];
                                  //             age = e.data()['age'];
                                  //             phone = e.data()['phoneNumber'];
                                  //             photo = e.data()['photoUrl'];
                                  //           },
                                  //         );
                                  //       }).toList(),
                                  //     );
                                  //   },
                                  // ),

                                  // ================   member selection   =================================================================================
                                  Row(
                                    children: [
                                      Container(
                                        // color: kRed,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                            left: 8,
                                            right: 8,
                                          ),
                                          child: FutureBuilder<Patients>(
                                            future: authC.getUserDetails(),
                                            builder: (context, user) {
                                              if (user.hasData) {
                                                name = user.data!.userName;

                                                age = user.data!.age;

                                                phone = user.data!.phoneNumber;

                                                photo = user.data!.photoUrl;
                                                gender = user.data!.gender;
                                              }

                                              return user.data == null
                                                  ? Center(
                                                      child: Container(),
                                                    )
                                                  : GetBuilder<StateController>(
                                                      init: StateController(),
                                                      id: 'member',
                                                      builder: (userControl) {
                                                        return InkWell(
                                                          onTap: () {
                                                            userControl
                                                                    .selectionMember =
                                                                true;
                                                            userControl
                                                                .memberSel = -1;
                                                            userControl.update(
                                                                ['member']);
                                                            userControl.update([
                                                              'memberControl'
                                                            ]);

                                                            name = user
                                                                .data!.userName;

                                                            age =
                                                                user.data!.age;

                                                            phone = user.data!
                                                                .phoneNumber;

                                                            photo = user
                                                                .data!.photoUrl;
                                                            gender = user
                                                                .data!.gender;

                                                            // print(photo);
                                                          },
                                                          child: Container(
                                                              height: 4.h,
                                                              width: 25.w,
                                                              decoration: BoxDecoration(
                                                                  color: userControl
                                                                              .selectionMember ==
                                                                          true
                                                                      ? kBlue
                                                                      : kWhite,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  border: Border.all(
                                                                      color:
                                                                          kBlue,
                                                                      width:
                                                                          1)),
                                                              child: Center(
                                                                child: Text(
                                                                  user
                                                                      .data!
                                                                      .userName
                                                                      .capitalize!,
                                                                  style:
                                                                      TextStyle(
                                                                    color: userControl.selectionMember ==
                                                                            true
                                                                        ? kWhite
                                                                        : kBlack,
                                                                  ),
                                                                ),
                                                              )),
                                                        );
                                                      },
                                                    );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: kGreen,
                                        height: 5.h,
                                        width: 70.w,
                                        child:
                                            StreamBuilder<
                                                    List<
                                                        QueryDocumentSnapshot<
                                                            Map<String,
                                                                dynamic>>>>(
                                                stream:
                                                    datacontrol.getMembers(),
                                                builder: (context, member) {
                                                  return Container(
                                                    width: 38.w,
                                                    height: 1.h,
                                                    // color: kBlue,
                                                    child: member.data == null
                                                        ? Center(
                                                            child: Text(
                                                                'No Members added!'),
                                                          )
                                                        : ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: member
                                                                .data!.length,
                                                            itemBuilder:
                                                                ((context,
                                                                    index) {
                                                              // print(
                                                              //     'member ${member.data!.first.data()}');

                                                              final members =
                                                                  member.data![
                                                                      index];

                                                              final userName =
                                                                  members[
                                                                      'userName'];

                                                              return Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    bottom: 8.0,
                                                                    left: 8,
                                                                    right: 8,
                                                                  ),
                                                                  child: GetBuilder<
                                                                      StateController>(
                                                                    init:
                                                                        StateController(),
                                                                    id: 'memberControl',
                                                                    builder:
                                                                        (memberControl) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          memberControl.memberSel =
                                                                              index;
                                                                          memberControl
                                                                              .update([
                                                                            'memberControl'
                                                                          ]);

                                                                          memberControl.selectionMember =
                                                                              false;
                                                                          memberControl
                                                                              .update([
                                                                            'member'
                                                                          ]);

                                                                          name =
                                                                              members['userName'];
                                                                          age =
                                                                              members['age'];
                                                                          phone =
                                                                              members['phoneNumber'];
                                                                          photo =
                                                                              members['photoUrl'];
                                                                          gender =
                                                                              members['gender'];
                                                                          // print(
                                                                          //     'photo $photo');
                                                                        },
                                                                        child: Container(
                                                                            height: 4.h,
                                                                            width: 20.w,
                                                                            decoration: BoxDecoration(color: memberControl.memberSel == index ? kBlue : kWhite, borderRadius: BorderRadius.circular(50), border: Border.all(color: kBlue, width: 1)),
                                                                            child: Center(
                                                                              child: Text(
                                                                                userName,
                                                                                style: TextStyle(
                                                                                  color: memberControl.memberSel == index ? kWhite : kBlack,
                                                                                ),
                                                                              ),
                                                                            )),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            })),
                                                  );
                                                }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              kHeight10,
                              Center(
                                child: Text(
                                  'Write your problem',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              kHeight10,
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: _key,
                                  child: TextFormField(
                                    controller: disController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Description',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Discription';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),

                              // Text('Full name',
                              //     style: TextStyle(
                              //       color: CupertinoColors.systemBlue,
                              //       fontSize: 15.0,
                              //     )),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     left: 15.0,
                              //     right: 15,
                              //     top: 5,
                              //   ),
                              //   child: TextFormField(
                              //     controller: nameController,
                              //     decoration: InputDecoration(
                              //       fillColor: Color.fromARGB(255, 236, 235, 229),
                              //       filled: true,
                              //       hintText: 'Full name',
                              //       contentPadding: EdgeInsets.symmetric(
                              //           vertical: 8.0, horizontal: 5.0),
                              //       border: OutlineInputBorder(
                              //         borderSide: BorderSide.none,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // kHeight10,
                              // Text('Age',
                              //     style: TextStyle(
                              //       color: CupertinoColors.systemBlue,
                              //       fontSize: 15.0,
                              //     )),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     left: 15.0,
                              //     right: 250,
                              //     top: 5,
                              //   ),
                              //   child: TextFormField(
                              //     controller: ageController,
                              //     decoration: const InputDecoration(
                              //       fillColor: Color.fromARGB(255, 236, 235, 229),
                              //       filled: true,
                              //       hintText: 'Age',
                              //       contentPadding: EdgeInsets.symmetric(
                              //           vertical: 8.0, horizontal: 5.0),
                              //       border: OutlineInputBorder(
                              //         borderSide: BorderSide.none,
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              //================================= gender ====================================

                              // kHeight10,
                              // const Text('Select Gender',
                              //     style: TextStyle(
                              //       color: CupertinoColors.systemBlue,
                              //       fontSize: 15.0,
                              //     )),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //     bottom: 5.0,
                              //     top: 5,
                              //     left: 15,
                              //   ),
                              //   child: CupertinoRadioChoice(
                              //       choices: genderMap,
                              //       onChange: onGenderSelected,
                              //       initialKeyValue: _selectedGender),
                              // ),
                              // kHeight10,
                              // const Text(,
                              //     style: TextStyle(
                              //       color: CupertinoColors.systemBlue,
                              //       fontSize: 15.0,
                              //     )),

                              kHeight30,

                              Center(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    String result = '';

                                    if (statecontrol.currentDate == -1) {
                                      result = 'Select Date';
                                      showSnackBar(result, kRed, context);
                                      return;
                                    }

                                    if (statecontrol.current == null) {
                                      result = 'select Time';
                                      showSnackBar(result, kRed, context);
                                      return;
                                    }
                                    if (name == null) {
                                      result = 'select patient';
                                      showSnackBar(result, kRed, context);
                                      return;

                                      // final userData = authC.getUserDetails();

                                      // name = await userData
                                      //     .then((value) => value.userName);
                                      // age = await userData.then((value) => value.age);
                                      // phone = await userData
                                      //     .then((value) => value.phoneNumber);
                                      // photo = await userData
                                      //     .then((value) => value.photoUrl);
                                      // print(photo);
                                    }
                                    // if (disController.text.isEmpty) {
                                    //   result = 'Write your problem';
                                    //   showSnackBar(result, kRed, context);
                                    //   return;
                                    // }

                                    // getMember();

                                    if (_key.currentState!.validate()) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen(
                                                    age: age ?? '',
                                                    date: _selectedDate!,
                                                    gender: gender ?? '',
                                                    name: name!,
                                                    problem: disController.text,
                                                    doctorId: docId,
                                                    phoneNum: phone!,
                                                    photo: photo!,
                                                    time: statecontrol.current,
                                                    dateId: dateID!,
                                                  )));
                                    }

                                    // showMyDialog(context);

                                    // print('-----22222${_selectedDate}');
                                    // print('${statecontrol.current}');
                                  },
                                  icon: Icon(Icons.payments_outlined),
                                  label: Text(
                                    'Continue to Payment',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 70, vertical: 13),
                                      primary: kBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                              ),
                            ],
                          ),
                        );
                },
              );
            } else {
              return Container(
                height: 100.h,
                width: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/error.gif',
                      // scale: .002,
                      width: 20.h,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text('Check your connection!'),
                  ],
                ),
              );
            }
          }),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    // print('show dialogue');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Write your problem'),
          content: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
              top: 5,
            ),
            child: Form(
              key: _key,
              child: TextFormField(
                controller: disController,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Discription';
                  }
                  return null;
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Confirm'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  GetBuilder<StateController> appoinmentTime(
      bool newTime, String time, bool control, currentIndex) {
    return GetBuilder<StateController>(
      init: StateController(),
      id: 'timeControl',
      builder: (stateController) {
        return InkWell(
          onTap: () {
            // print(
            //     "dropdate value before ${stateController.selectedeValue} control: ${control} ");
            if (stateController.dropDateValue != null) {
              if (newTime == true) {
                stateController.current = time;
              }
            }
            stateController.update(['timeControl']);
            // print(
            //     "dropdate value after ${stateController.current} control: ${control} ");
          },
          child: Container(
            width: 16.w,
            height: 3.6.h,
            decoration: BoxDecoration(
                color: newTime == false
                    ? Colors.grey
                    : stateController.current == time
                        ? kBlue
                        : kWhite,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: kBlue, width: 1)),
            child: Center(
                child: Text(
              time,
              style: TextStyle(
                  color: newTime == false
                      ? kBlack
                      : stateController.current == time
                          ? kWhite
                          : kBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )),
          ),
        );
      },
    );
  }
}

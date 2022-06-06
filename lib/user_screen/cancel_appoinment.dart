import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:doctor_appointment/user_screen/widget/rating_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class CancelAppoinment extends StatelessWidget {
  final data;
  final appoID;
  final isUpComing;
  const CancelAppoinment({Key? key, this.data, this.appoID, this.isUpComing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Doctor;

    final String docPhoto = data.doctorDetails.photoUrl;
    // print(docPhoto);
    final String docName = data.doctorDetails.userName;
    final String docPhone = data.doctorDetails.phoneNumber;
    final String docSpeciality = data.doctorDetails.speciality['name'];
    final DateTime appoDate = data.appoDetails.date;
    final String time = data.appoDetails.time;
    final String about = data.doctorDetails.about;
    final date = DateFormat('dd/MM/yyyy').format(appoDate);
    final String docID = data.appoDetails.doctorId;
    final String schedID = data.appoDetails.scheduleID;
    final String experience = data.doctorDetails.experience;
    final String patientName = data.appoDetails.name;
    final String isCanceled = data.appoDetails.status;

    datacontrol.getRatingAndReview(doctorID: docID);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
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
        //automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'assets/log_illu/Doctor-color-800px.png',
              child: Material(
                type: MaterialType.transparency,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kGrey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          docPhoto,
                        ),
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //   },
                            //   child: Container(
                            //     height: 24,
                            //     width: 24,
                            //     decoration: const BoxDecoration(
                            //       image: DecorationImage(
                            //         image: Svg('assets/svg/icon-back.svg'),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //   },
                            //   child: Container(
                            //     height: 24,
                            //     width: 24,
                            //     decoration: const BoxDecoration(
                            //       image: DecorationImage(
                            //         image: Svg('assets/svg/icon-bookmark.svg'),
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: 50.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 14.h,
                          height: 7.h,
                          decoration: BoxDecoration(
                              // color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kBlue, width: 1)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Experience',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    experience,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'yr',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: kGrey,
                        ),
                        GetBuilder<DataController>(
                          init: DataController(),
                          id: 'rating',
                          builder: (patients) {
                            return Container(
                              width: 14.h,
                              height: 7.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: kBlue, width: 1)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Patients',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        patients.totalPatient.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Ps',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: kGrey,
                        ),
                        GetBuilder<DataController>(
                          init: DataController(),
                          id: 'rating',
                          builder: (rating) {
                            return Container(
                              width: 13.h,
                              height: 7.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: kBlue, width: 1)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Rating',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        rating.totalRating.isNaN
                                            ? '0'
                                            : rating.totalRating
                                                .toStringAsFixed(1),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Hero(
                        tag: Text('Dr name'),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            'Dr ${docName.capitalize}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 3.h,
                        width: 12.h,
                        decoration: BoxDecoration(
                            // color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: kRed, width: 1.2)),
                        child: Center(
                          child: Text(
                            docSpeciality.toUpperCase(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHeight20,
                  Container(
                    width: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 4.h,
                          width: 12.h,
                          decoration: BoxDecoration(
                              // color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kBlue, width: 1.2)),
                          child: Center(
                            child: Text(
                              DateFormat('dd.MM.yyyy').format(appoDate),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          height: 4.h,
                          width: 12.h,
                          decoration: BoxDecoration(
                              // color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kBlue, width: 1.2)),
                          child: Center(
                            child: Text(
                              time,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(about,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(fontSize: 13)),
                  const SizedBox(
                    height: 16,
                  ),
                  //const Spacer(),

                  kHeight20,
                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          launchUrl(Uri(scheme: 'tel', path: docPhone));
                        },
                        child: Container(
                          height: 6.h,
                          width: 6.h,
                          decoration: BoxDecoration(
                            color: kGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.call,
                            color: kWhite,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // print(appoID);
                          // print(time);
                          // print(date);
                          // print(docID);
                          // print(schedID);

                          if (isCanceled != 'canceled') {
                            if (isUpComing == true) {
                              authC.cancelAppoin(
                                appoID: appoID,
                                time: time,
                                date: appoDate,
                                docID: docID,
                                scheduleID: schedID,
                                name: patientName,
                              );
                              datacontrol.update(['appointment']);
                              Navigator.pop(context);
                              //print('cancel');
                            } else {
                              openRatingDialog(context, appoID);
                              // datacontrol.getRatingAndReview(doctorID: docID);
                              // print('rate');
                            }
                          }
                        },
                        child: Container(
                          height: 6.h,
                          width: 35.h,
                          decoration: BoxDecoration(
                            gradient: isCanceled == 'canceled'
                                ? LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 236, 4, 4),
                                      Color.fromARGB(255, 246, 84, 84),
                                    ],
                                  )
                                : LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 18, 67, 214),
                                      Color.fromARGB(255, 35, 134, 247),
                                    ],
                                  ),
                            borderRadius: BorderRadius.circular(20),
                            color: kBlue,
                          ),
                          child: Center(
                            child: Text(
                              isCanceled == 'canceled'
                                  ? 'Canceled'
                                  : isUpComing == true
                                      ? 'Cancel Appoinment'
                                      : 'Rate Doctor',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: kWhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  openRatingDialog(BuildContext context, String docID) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: RatingWidget(
              docID: docID,
            ),
          );
        });
  }
}

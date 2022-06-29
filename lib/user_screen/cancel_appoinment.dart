import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/chat_screen/chat_screen.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:doctor_appointment/user_screen/widget/rating_widget.dart';
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
    final String docPhoto = data.doctorDetails.photoUrl;
    final String docName = data.doctorDetails.userName;
    final String docPhone = data.doctorDetails.phoneNumber;
    String docSpeciality = "Genaral";
    if (data.doctorDetails.speciality['name'] != null) {
      docSpeciality = data.doctorDetails.speciality['name'];
    }

    final DateTime appoDate = data.appoDetails.date;
    final String time = data.appoDetails.time;
    final String about = data.doctorDetails.about;
    final String docID = data.appoDetails.doctorId;
    final String schedID = data.appoDetails.scheduleID;
    final String experience = data.doctorDetails.experience;
    final String patientName = data.appoDetails.name;
    final String isCanceled = data.appoDetails.status;

    datacontrol.getRatingAndReview(doctorID: docID);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
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
                              const Text('Experience',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    experience,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
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
                                  const Text('Patients',
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
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Text(
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
                                  const Text('Rating',
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
                                        style: const TextStyle(fontSize: 16),
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
                    children: [
                      Hero(
                        tag: const Text('Dr name'),
                        child: Material(
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 60.w,
                            child: Text(
                              'Dr ${docName.capitalize}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline5,
                            ),
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
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: kRed, width: 1.2)),
                        child: Center(
                          child: Text(
                            docSpeciality.toUpperCase(),
                            style: const TextStyle(fontSize: 12),
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
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kBlue, width: 1.2)),
                          child: Center(
                            child: Text(
                              DateFormat('dd.MM.yyyy').format(appoDate),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          height: 4.h,
                          width: 12.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kBlue, width: 1.2)),
                          child: Center(
                            child: Text(
                              time,
                              style: const TextStyle(fontSize: 12),
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
                      style: const TextStyle(fontSize: 13)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      isUpComing == true
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            doctorId: docID,
                                            doctorNmae: docName.capitalize!,
                                            doctorImage: docPhoto)));
                              },
                              child: Container(
                                height: 6.h,
                                width: 6.h,
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade700,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.chat,
                                  color: kWhite,
                                ),
                              ),
                            )
                          : Container(),
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
                          child: const Icon(
                            Icons.call,
                            color: kWhite,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
                            } else {
                              openRatingDialog(context, appoID);
                            }
                          }
                        },
                        child: Container(
                          height: 6.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                            gradient: isCanceled == 'canceled'
                                ? const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 236, 4, 4),
                                      Color.fromARGB(255, 246, 84, 84),
                                    ],
                                  )
                                : const LinearGradient(
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
                                      ? 'Cancel Appointment'
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

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/models/doc_appointment.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/cancel_appoinment.dart';
import 'package:doctor_appointment/user_screen/skeleton_screens/skeleton_home.dart';
import 'package:doctor_appointment/user_screen/widget/connection_lost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AppointmentWidget extends StatelessWidget {
  bool isUpcoming;
  AppointmentWidget({Key? key, required this.isUpcoming}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  final dataControl = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasData && snapshot.data != ConnectivityResult.none) {
            return GetBuilder<DataController>(
                init: DataController(),
                id: 'appointment',
                builder: (appointment) {
                  return FutureBuilder<List<DoctorAppointment>>(
                    future: isUpcoming == true
                        ? appointment.getUpcomingApp()
                        : appointment.pastRefresh(),
                    builder: (context, snapshot) {
                      final fullDetails = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SkeletonHome();
                      }
                      if (fullDetails == null || fullDetails.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/no appointment.png',
                                scale: .8,
                              ),
                              const Text('Nothing to show here'),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                          ),
                          itemBuilder: (ctx, index) {
                            final String docPhoto =
                                fullDetails[index].doctorDetails.photoUrl;
                            // print(docPhoto);
                            final String docName =
                                fullDetails[index].doctorDetails.userName;
                            String docSpeciality = "Genaral";
                            if (fullDetails[index]
                                    .doctorDetails
                                    .speciality['name'] !=
                                null) {
                              docSpeciality = fullDetails[index]
                                  .doctorDetails
                                  .speciality['name'];
                            }

                            final DateTime appoDate =
                                fullDetails[index].appoDetails.date;
                            final String time =
                                fullDetails[index].appoDetails.time;
                            final String patientName =
                                fullDetails[index].appoDetails.name;
                            final appoID =
                                fullDetails[index].appoDetails.bookingId;
                            final date =
                                DateFormat('dd/MM/yyyy').format(appoDate);
                            final isCanceled =
                                fullDetails[index].appoDetails.status;

                            return Padding(
                              padding: const EdgeInsets.only(top: 6, bottom: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                 ),

                                child: SizedBox(
                                  height: 16.h,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CancelAppoinment(
                                                    data: fullDetails[index],
                                                    appoID: appoID,
                                                    isUpComing: isUpcoming,
                                                  )));
                                    },
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                                  left: Radius.circular(10)),
                                          child: SizedBox(
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Image.network(docPhoto)),
                                            height: double.infinity,
                                            width: 14.h,
                                          ),
                                        ),
                                        kWidth20,
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // kHeight10,
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                              width: 26.h,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                      width: 24.h,
                                                      child: Text(
                                                        docName.capitalize!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                  isCanceled == 'canceled'
                                                      ? Container(
                                                          height: 3.h,
                                                          width: 11.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: kRed,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: const Center(
                                                              child: Text(
                                                                  'Canceled',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kWhite,
                                                                      fontSize:
                                                                          12))),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            kHeight10,
                                            Text(docSpeciality.toUpperCase()),
                                            kHeight10,
                                            Row(
                                              children: [
                                                Text(
                                                  'Patient : ',
                                                  style: TextStyle(color: kRed),
                                                ),
                                                SizedBox(
                                                  width: 20.h,
                                                  child: Text(
                                                    patientName.capitalize!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(color: kRed),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 26.h,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16, right: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: kBlue,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                      ),
                                                      child: Center(
                                                          child: Text(date)),
                                                    ),
                                                    kWidth10,
                                                    Container(
                                                      height: 25,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          border: Border.all(
                                                              color: kBlue,
                                                              width: 1)),
                                                      child: Center(
                                                          child: Text(time)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: fullDetails.length);
                    },
                  );
                });
          } else {
            return const ConnectionLost();
          }
        });
  }
}

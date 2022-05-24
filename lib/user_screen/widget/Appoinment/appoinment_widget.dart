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

class AppointmentWidget extends StatelessWidget {
  bool isUpcoming;
  AppointmentWidget({Key? key, required this.isUpcoming}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  final dataControl = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    // print("screen 121");
    final size = MediaQuery.of(context).size.height;
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
                        return SkeletonHome();
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
                              Text('Nothing to show here'),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                          controller: scrollController,
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                          ),
                          itemBuilder: (ctx, index) {
                            //final nelist = dataControl.getAppointmentDetails();
                            //  print("121 ${fullDetails.length}");
                            final String docPhoto =
                                fullDetails[index].doctorDetails.photoUrl;
                            // print(docPhoto);
                            final String docName =
                                fullDetails[index].doctorDetails.userName;
                            final String docSpeciality = fullDetails[index]
                                .doctorDetails
                                .speciality['name'];
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
                                // elevation: 2.5,
                                // / color: kGrey,
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: .2,
                                      // spreadRadius: .1,
                                      // blurStyle: BlurStyle.outer
                                      // offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),

                                child: SizedBox(
                                  height: 120,
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
                                      //crossAxisAlignment: CrossAxisAlignment.center,
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
                                            width: size * .14,
                                          ),
                                        ),
                                        // Container(
                                        //   height: 90,
                                        //   width: 80,
                                        //   decoration: BoxDecoration(
                                        //     // color: kBlue,
                                        //     borderRadius: BorderRadius.circular(6.0),
                                        //   ),
                                        //   child:
                                        //       Image.asset('assets/log_illu/Doctor-color-800px.png'),
                                        // ),
                                        kWidth20,
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            kHeight10,
                                            Container(
                                              width: size * .26,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(docName.capitalize!),
                                                  isCanceled == 'canceled'
                                                      ? Container(
                                                          height: size * .03,
                                                          width: size * .11,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: kRed,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: Center(
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
                                            // kHeight10,
                                            Text(docSpeciality.toUpperCase()),
                                            kHeight10,
                                            Row(
                                              children: [
                                                Text(
                                                  'Patient : ',
                                                  style: TextStyle(color: kRed),
                                                ),
                                                Text(
                                                  patientName.capitalize!,
                                                  style: TextStyle(color: kRed),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: size * .26,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7, right: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        //color: kBlue,
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
                                                          // color: kBlue,
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
                                            kHeight10
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
            return ConnectionLost();
          }
        });
  }
}

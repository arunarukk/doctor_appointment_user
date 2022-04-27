import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/widget/Appoinment/make_appoinment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorDetailScreen extends StatelessWidget {
  final data;
  DoctorDetailScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Doctor;
    final size = MediaQuery.of(context).size.height;

    datacontrol.getRatingAndReview(doctorID: data['uid']);

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
                child: Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: kGrey,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        data['photoUrl'],
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
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.44,
              width: size * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size * .14,
                          height: size * .07,
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
                                    data['experience'],
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
                          builder: (patient) {
                            return Container(
                              width: size * .14,
                              height: size * .07,
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
                                        patient.totalPatient.toString(),
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
                              width: size * .13,
                              height: size * .07,
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
                                        rating.totalRating.toString(),
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
                    children: [
                      Hero(
                        tag: Text('Dr name'),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            'Dr ${data['userName']}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      kWidth10,
                      Container(
                        height: size * .03,
                        width: size * .12,
                        decoration: BoxDecoration(
                            // color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: kRed, width: 1.2)),
                        child: Center(
                          child: Text(
                            data['speciality']['name'].toString().toUpperCase(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  Text(data['about'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(fontSize: 13)),

                  //const Spacer(),

                  // kHeight20,
                  // const Spacer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: kBlue,
                        //   ),
                        //   child: Icon(
                        //     Icons.chat_outlined,
                        //     color: kWhite,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 16,
                        // ),
                        Center(
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MakeAppoinment(
                                          docId: data['uid'],
                                        ))),
                            child: Container(
                              height: size * .06,
                              width: MediaQuery.of(context).size.width - 104,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
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
                                  'Make an Appoinment',
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

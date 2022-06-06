import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/widget/appbar_wiget.dart';
import 'package:doctor_appointment/user_screen/widget/connection_lost.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/top_doctors_home.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_profile.dart';
import 'package:doctor_appointment/user_screen/widget/main_title_widget.dart';
import 'package:doctor_appointment/user_screen/widget/search_bar/search_bar_widget.dart';
import 'package:doctor_appointment/user_screen/widget/speciality_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletons/skeletons.dart';

import '../../constant_value/constant_colors.dart';
import '../widget/doctor_list_widget/doctor_list_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final control = Get.put(DataController());

  @override
  void initState() {
    notifyC.storeToken();
    // notifyC.sayHi();
    addData();
    super.initState();
  }

  addData() async {
    final statecontrol = Get.put(StateController());
    await statecontrol.refreshUser();
    statecontrol.update();
  }

  @override
  Widget build(BuildContext context) {
    //  print('-----------${FirebaseAuth.instance.currentUser}');
    // Connectivity().onConnectivityChanged;
    // control.querySelec == false;

    datacontrol.querySelection(false);

    return Scaffold(
      appBar: PreferredSize(
          child: AppBarWidget(
            title: 'Home',
          ),
          preferredSize: Size.fromHeight(60)),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
              // if (snapshot.data == null) {
              //   Connectivity().onConnectivityChanged;
              //   return Text('null');
              // }
              //print('connenction ${snapshot}');
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data != null &&
                      snapshot.hasData &&
                      snapshot.data != ConnectivityResult.none) {
                return Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 4.h),
                        GetBuilder<StateController>(
                          builder: (controller) {
                            return StreamBuilder<Patients>(
                                stream: controller.getUserProfileDetails(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SkeletonItem(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SkeletonParagraph(
                                          style: SkeletonParagraphStyle(
                                              lines: 1,
                                              spacing: 25,
                                              lineStyle: SkeletonLineStyle(
                                                randomLength: true,
                                                height: 35,
                                                borderRadius:
                                                    BorderRadius.vertical(),
                                                minLength: 9.w,
                                                maxLength: 10.w,
                                              )),
                                        ),
                                        SkeletonParagraph(
                                          style: SkeletonParagraphStyle(
                                              lines: 1,
                                              spacing: 25,
                                              lineStyle: SkeletonLineStyle(
                                                randomLength: true,
                                                height: 20,
                                                borderRadius:
                                                    BorderRadius.vertical(),
                                                minLength: 34.w,
                                                maxLength: 35.w,
                                              )),
                                        ),
                                      ],
                                    ));
                                    // CupertinoActivityIndicator(
                                    //   color: kBlue,
                                    // );
                                  }
                                  if (snapshot.data == null ||
                                      snapshot.data!.userName.isEmpty) {
                                    return Text(
                                      'Hola',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: kBlue,
                                      ),
                                    );
                                  }

                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Hi, ',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: kBlue,
                                        ),
                                      ),
                                      Text(
                                        ' ${snapshot.data!.userName.capitalize}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: kBlue,
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                        )
                      ],
                    ),
                    //kHeight30,
                    Container(
                      //color: Colors.amber,
                      height: 26.h,
                      width: 200.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        // clipBehavior: Clip.hardEdge,
                        children: [
                          Positioned(
                            bottom: 5,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Color.fromARGB(157, 119, 158, 255),
                              child: Container(
                                height: 20.h,
                                width: 70.w,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Color.fromARGB(157, 119, 158, 255),
                              child: Container(
                                height: 20.h,
                                width: 78.w,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            child: Container(
                              height: 21.h,
                              width: 83.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  gradient: LinearGradient(colors: [
                                    Color(0xff5B7FFF),
                                    Color(0xff00229C)
                                  ])),
                              child: Row(
                                children: [
                                  kWidth20,
                                  Column(
                                    children: [
                                      kHeight30,
                                      Text(
                                        'Need a Doctor ?',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      kHeight20,
                                      Text(
                                        'World’s Best Doctor’s\nare to answer your\nquestions',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              right: 70,
                              bottom: 25,
                              child: Container(
                                height: 22.9.h,
                                child: Image.asset('assets/doctor_home.png'),
                              ))
                        ],
                      ),
                    ),

                    Stack(
                      children: [
                        Column(
                          children: [
                            SearchBar(),
                            SpecialityWidget(
                              title: 'Speciality',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const MainTitle(title: 'Top Doctors'),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorList()));
                                    },
                                    child: Text(
                                      'See all',
                                      style: TextStyle(color: kBlue),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            TopDoctors(),
                          ],
                        ),
                        GetBuilder<DataController>(
                          init: DataController(),
                          id: 'search',
                          builder: (search) {
                            if (search.querySelec == true) {
                              if (search.snapshot.isEmpty) {
                                return Positioned(
                                    top: 80,
                                    left: 20.h,
                                    child: Text(
                                      'No data found!',
                                      style: TextStyle(color: kRed),
                                    ));
                              }
                              //print(search.snapshot!.docs.['userName']);
                              return Positioned(
                                top: 70,
                                left: 0,
                                child: Container(
                                  height: 50.h,
                                  width: 100.w,
                                  color: Color.fromARGB(100, 255, 255, 255),
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        // print(search.snapshot);
                                        String name =
                                            search.snapshot[index]['userName'];

                                        String photoUrl =
                                            search.snapshot[index]['photoUrl'];

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0, right: 30),
                                          child: Card(
                                            color: kWhite,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: SizedBox(
                                              height: 10.h,
                                              child: InkWell(
                                                onTap: (() {
                                                  //print(doctor!.email);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DoctorDetailScreen(
                                                                data: search
                                                                        .snapshot[
                                                                    index],
                                                              )));
                                                  // FocusScope.of(context)
                                                  //     .requestFocus(FocusNode());
                                                }),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .horizontal(
                                                              left: Radius
                                                                  .circular(
                                                                      15)),
                                                      child: SizedBox(
                                                        child: FittedBox(
                                                            fit: BoxFit.cover,
                                                            child:
                                                                Image.network(
                                                                    photoUrl)),
                                                        height: 100.h,
                                                        width: 13.h,
                                                      ),
                                                    ),
                                                    kWidth20,
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            width: 19.h,
                                                            child: Text(
                                                                'Dr ${name.capitalize}')),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          height: 0,
                                        );
                                      },
                                      itemCount: search.snapshot.isEmpty
                                          ? 0
                                          : search.snapshot.length),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return ConnectionLost();
              }
            }),
      ),
    );
  }
}

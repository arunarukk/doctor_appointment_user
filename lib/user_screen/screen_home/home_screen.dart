import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/widget/appbar_wiget.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/top_doctors_home.dart';
import 'package:doctor_appointment/user_screen/widget/main_title_widget.dart';
import 'package:doctor_appointment/user_screen/widget/search_bar/search_bar_widget.dart';
import 'package:doctor_appointment/user_screen/widget/speciality_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant_value/constant_colors.dart';
import '../widget/doctor_list_widget/doctor_list_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final control = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBarWidget(
            title: 'Home',
          ),
          preferredSize: Size.fromHeight(60)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: size * 0.04),
                GetBuilder<StateController>(
                  builder: (controller) {
                    return controller.user == null
                        ? Text(
                            'Hola',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: kBlue,
                            ),
                          )
                        : Row(
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
                                ' ${controller.user!.userName.capitalize}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kBlue,
                                ),
                              )
                            ],
                          );
                  },
                )
              ],
            ),
            //kHeight30,
            Container(
              //color: Colors.amber,
              height: size * .26,
              width: size * 2,
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
                        height: 100,
                        width: 270,
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
                        height: 100,
                        width: 300,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    child: Container(
                      height: 160,
                      width: 330,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                              colors: [Color(0xff5B7FFF), Color(0xff00229C)])),
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
                        height: 180,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorList()));
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
                  builder: (control) {
                    if (control.querySelec == true) {
                      return Positioned(
                        top: 70,
                        left: 45,
                        child: Container(
                          height: size * .5,
                          width: size * .38,
                          color: Color.fromARGB(100, 255, 255, 255),
                          child: control.snapshot == null
                              ? Center(
                                  child: Text('sorry'),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    String name = control.snapshot!.docs[index]
                                        ['userName'];

                                    String photoUrl = control
                                        .snapshot!.docs[index]['photoUrl'];

                                    return control.snapshot == null
                                        ? Center(
                                            child: Text('sorry'),
                                          )
                                        : Card(
                                            color: kWhite,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: SizedBox(
                                              height: size * .1,
                                              width: double.infinity,
                                              child: InkWell(
                                                onTap: (() {
                                                  //print(doctor!.email);
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             PatientAppointmentScreen()));
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
                                                        height: size * 1,
                                                        width: size * .13,
                                                      ),
                                                    ),
                                                    kWidth20,
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            width: size * .19,
                                                            child: Text(
                                                                'Dr ${name.capitalize}')),
                                                      ],
                                                    ),
                                                  ],
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
                                  itemCount: control.snapshot == null
                                      ? 0
                                      : control.snapshot!.docs.length),
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
        ),
      ),
    );
  }
}

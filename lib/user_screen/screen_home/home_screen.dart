import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/user_screen/widget/appbar_wiget.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/top_doctors_home.dart';
import 'package:doctor_appointment/user_screen/widget/main_title_widget.dart';
import 'package:doctor_appointment/user_screen/widget/search_bar/search_bar_widget.dart';
import 'package:doctor_appointment/user_screen/widget/speciality_widget.dart';
import 'package:flutter/material.dart';

import '../../constant_value/constant_colors.dart';
import '../widget/doctor_list_widget/doctor_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBarWidget(
            title: 'Home',
          ),
          preferredSize: Size.fromHeight(60)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.1,
                ),
                Text(
                  'Hi, name',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kBlue,
                  ),
                ),
              ],
            ),
            //kHeight30,
            Container(
              //color: Colors.amber,
              height: size.height * .28,
              width: size.width * 2,
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
      ),
    );
  }
}

import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/user_screen/widget/speciality_list_doctor_widget.dart';
import 'package:flutter/material.dart';

class SpecialityWidget extends StatelessWidget {
  SpecialityWidget({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: kBlue,
      height: 200,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            kHeight10,
            LimitedBox(
              maxHeight: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  10,
                  (index) => InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                        bottom: 2,
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        // height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              // offset: Offset.zero, //(x,y)
                              blurRadius: .2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.tablet_android),
                              kHeight20,
                              Text('Ortho'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SpecialityWiseDoctor()));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

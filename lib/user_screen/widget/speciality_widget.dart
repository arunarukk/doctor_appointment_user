import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/resources/specialty_mathod.dart';
import 'package:doctor_appointment/user_screen/widget/speciality_list_doctor_widget.dart';
import 'package:flutter/material.dart';

class SpecialityWidget extends StatelessWidget {
  SpecialityWidget({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Container(
      //color: kBlue,
      height: size * .28,
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
              maxHeight: size * .21,
              child: FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
                  future: getSpeciality(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // print('waiting');
                    }
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<QueryDocumentSnapshot<Object?>> allvalue =
                        snapshot.data!;

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        allvalue.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(15.0),
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
                            height: size * .13,
                            width: size * .14,
                            child: InkWell(
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
                                    child: SizedBox(
                                      child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Image.network(
                                              allvalue[index]['photoUrl'])),
                                      height: size * .14,
                                      width: size * 1,
                                    ),
                                  ),
                                  //kWidth20,
                                  SizedBox(
                                    height: size * .04,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Text(
                                          allvalue[index]['name']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: kBlue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                final newInt = allvalue[index]['did'];
                                final speciality = allvalue[index]['name']
                                    .toString()
                                    .toUpperCase();
                                //print(newInt.toString().toUpperCase());
                                // getSpeciality();
                                // print(newInt);
                                // getListWise(allvalue[index]['did']);
                                // print(allvalue[index]['name']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SpecialityWiseDoctor(
                                              title: speciality,
                                              dataId: allvalue[index].id,
                                            )));
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

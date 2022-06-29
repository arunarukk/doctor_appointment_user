import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/resources/specialty_mathod.dart';
import 'package:doctor_appointment/user_screen/skeleton_screens/skeleton_speciality.dart';
import 'package:doctor_appointment/user_screen/widget/speciality_list_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SpecialityWidget extends StatelessWidget {
  SpecialityWidget({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 28.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            kHeight10,
            LimitedBox(
              maxHeight: 21.h,
              child: FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
                  future: getSpeciality(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SkeletonSpeciality();
                    }
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text('No Data'),
                      );
                    }

                    List<QueryDocumentSnapshot<Object?>> allvalue =
                        snapshot.data!;

                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        allvalue.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: const[
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: .2,
                                 )
                              ],
                            ),
                            height: 13.h,
                            width: 14.h,
                            child: InkWell(
                              child: Column(
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
                                      height: 14.h,
                                      width: 100.h,
                                    ),
                                  ),
                                   SizedBox(
                                    height: 4.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
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
                                final speciality = allvalue[index]['name']
                                    .toString()
                                    .toUpperCase();
                                 FocusManager.instance.primaryFocus?.unfocus();
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

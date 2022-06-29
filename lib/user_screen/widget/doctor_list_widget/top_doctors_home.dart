import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/user_screen/skeleton_screens/skeleton_top_doctors.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TopDoctors extends StatelessWidget {
  TopDoctors({Key? key}) : super(key: key);
  final authC = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LimitedBox(
          maxHeight: 14.h,
          child: FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
              future: authC.getdoctorDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return const SkeletonTopDoctors();
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('sorry!'),
                  );
                }

                List<QueryDocumentSnapshot<Object?>> allvalue = snapshot.data!;
             
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      allvalue.length <= 5 ? allvalue.length : 5, (index) {
                    String? drSpeciality;

                    if (allvalue[index]['speciality']['name'] == null) {
                      drSpeciality = 'General';
                    } else {
                      drSpeciality = allvalue[index]['speciality']['name']
                          .toString()
                          .toUpperCase();
                    }
                    final name = allvalue[index]['userName'];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        height: 16.h,
                        width: 16.h,
                        child: InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorDetailScreen(
                                          data: allvalue[index],
                                        )));
                          },
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
                                  height: 16.h,
                                  width: 100.h,
                                ),
                              ),
                              SizedBox(
                                height: 5.7.h,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 100.w,
                                      child: Center(
                                        child: Text(
                                          'Dr ${name.toString().capitalize}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: kBlue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: .4,
                                      width: 13.h,
                                      color: kBlue,
                                    ),
                                    Text(
                                      drSpeciality == null
                                          ? 'General'
                                          : drSpeciality,
                                      style:
                                          TextStyle(color: kBlue, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
        ),
      ),
    );
  }
}

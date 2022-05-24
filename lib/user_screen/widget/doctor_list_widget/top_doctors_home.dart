import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/user_screen/skeleton_screens/skeleton_top_doctors.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopDoctors extends StatelessWidget {
  TopDoctors({Key? key}) : super(key: key);
  final authC = AuthMethods();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return SizedBox(
      height: size * .25,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LimitedBox(
          maxHeight: size * .14,
          child: FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
              future: authC.getdoctorDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //  print('waiting');
                  return SkeletonTopDoctors();
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('sorry!'),
                  );
                }

                List<QueryDocumentSnapshot<Object?>> allvalue = snapshot.data!;
                // print(allvalue[0]['email']);

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      allvalue.length <= 5 ? allvalue.length : 5, (index) {
                    String? drSpeciality;
                    if (allvalue[index]['speciality'] == null) {
                      drSpeciality = 'General';
                    } else {
                      drSpeciality = allvalue[index]['speciality']['name']
                          .toString()
                          .toUpperCase();
                    }
                    final name = allvalue[index]['userName'];
                    // print(name.capitalize);
                    return Card(
                      //color: kBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        height: size * .16,
                        width: size * .16,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorDetailScreen(
                                          data: allvalue[index],
                                        )));
                          },
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
                                  height: size * .16,
                                  width: size * 1,
                                ),
                              ),
                              //kWidth20,
                              SizedBox(
                                height: size * .057,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dr ${name.toString().capitalize}',
                                      style: TextStyle(
                                          color: kBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: .4,
                                      width: size * .13,
                                      color: kBlue,
                                    ),
                                    Text(
                                      drSpeciality,
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

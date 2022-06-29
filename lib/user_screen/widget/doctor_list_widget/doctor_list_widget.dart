import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/user_screen/skeleton_screens/skeleton_doctorlist.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

final authC = AuthMethods();

class DoctorList extends StatelessWidget {
  DoctorList({
    Key? key,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctors',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kBlack,
            )),
       ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
          future: authC.getdoctorDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SkeletonDoctorList();
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Sorry no doctor\'s available now'),
              );
            }

            List<QueryDocumentSnapshot<Object?>> allvalue = snapshot.data!;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  mainAxisExtent: 21.h,
                ),
                controller: scrollController,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                itemBuilder: (ctx, index) {
                  return Card(
                    color: kBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
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
                         children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: SizedBox(
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(
                                        allvalue[index]['photoUrl'])),
                                height: 16.h,
                                width: 100.h,
                              ),
                            ),
                            // kWidth20,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100.w,
                                    child: Center(
                                      child: Text(
                                        'Dr ${allvalue[index]['userName']}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: kWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                 Text(
                                    allvalue[index]['speciality']['name'] ==
                                            null
                                        ? 'General'
                                        : allvalue[index]['speciality']['name']
                                            .toString()
                                            .toUpperCase(),
                                    style: const TextStyle(
                                      color: kWhite,
                                      fontSize: 10,
                                   ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: allvalue.length);
          }),
    );
  }
}

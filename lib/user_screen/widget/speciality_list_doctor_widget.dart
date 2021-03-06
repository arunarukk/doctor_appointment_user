import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/resources/specialty_mathod.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SpecialityWiseDoctor extends StatelessWidget {
  final dataId;
  final title;
  SpecialityWiseDoctor({Key? key, this.title, this.dataId}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: kBlack),
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
          future: getListWise(dataId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('No Data'),
              );
            }

            List<QueryDocumentSnapshot<Object?>> allvalue = snapshot.data!;

            return allvalue.isEmpty
                ? const Center(child: Text('No doctors Available'))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      mainAxisExtent: 21.h,
                    ),
                    controller: scrollController,
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                                kWidth20,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 100.w,
                                      child: Center(
                                        child: Text(
                                          'Dr ${allvalue[index]['userName']}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(color: kWhite),
                                        ),
                                      ),
                                    ),
                                  ],
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

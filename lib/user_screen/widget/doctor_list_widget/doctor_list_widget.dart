import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_profile.dart';
import 'package:flutter/material.dart';

import '../../../constant_value/constant_size.dart';

final authC = AuthMethods();

class DoctorList extends StatelessWidget {
  DoctorList({
    Key? key,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: kBlack,
            )),
        //automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
          future: authC.getdoctorDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('waiting');
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null) {
              return Center(
                child: Text('sorry doctor\'s available now'),
              );
            }

            List<QueryDocumentSnapshot<Object?>> allvalue = snapshot.data!;
            // print(allvalue[0]['email']);

            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  mainAxisExtent: size * .21,
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
                      //height: 200,
                      // width: 50,
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
                                  top: Radius.circular(15)),
                              child: SizedBox(
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(
                                        allvalue[index]['photoUrl'])),
                                height: size * .16,
                                width: size * 1,
                              ),
                            ),
                            // kWidth20,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  Text(
                                    'Dr ${allvalue[index]['userName']}',
                                    style: TextStyle(
                                      color: kWhite,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 2,
                                  // ),
                                  Text(
                                    allvalue[index]['speciality']['name']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: kWhite,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/add_member.dart';
import 'package:doctor_appointment/user_screen/skeleton_screens/skeleton_member.dart';
import 'package:doctor_appointment/user_screen/widget/connection_lost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MembersScreen extends StatelessWidget {
  MembersScreen({
    Key? key,
  }) : super(key: key);

  final control = Get.put(DataController());

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Members',
          style: TextStyle(color: kBlack),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMembers(
                              title: 'Add member',
                            )));
              },
              icon: Icon(
                Icons.add,
                color: kBlack,
              ))
        ],
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
      ),
      body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasData && snapshot.data != ConnectivityResult.none) {
              return GetBuilder<DataController>(
                init: DataController(),
                id: 'member',
                builder: (member) {
                  return StreamBuilder<
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                      stream: member.getMembers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SkeletonMember();
                        }
                        print(snapshot.data);
                        return snapshot.data == null || snapshot.data!.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_off_outlined,
                                      size: 150,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "Add members",
                                      style: TextStyle(color: kBlack),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.separated(
                                controller: scrollController,
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                itemBuilder: (ctx, index) {
                                  // print(snapshot.data![index].data());
                                  final String name =
                                      snapshot.data![index].data()['userName'];
                                  final String age =
                                      snapshot.data![index].data()['age'];
                                  final String photoUrl =
                                      snapshot.data![index].data()['photoUrl'];
                                 // print(snapshot.data![index].id);
                                  return Card(
                                    color: kWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      height: 100,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddMembers(
                                                        title: 'Update',
                                                        data: snapshot
                                                            .data![index]
                                                            .data(),
                                                        uid: snapshot
                                                            .data![index].id,
                                                      )));
                                        },
                                        // leading: CircleAvatar(
                                        //   radius: 40,
                                        //   backgroundColor: Colors.white,
                                        //   backgroundImage: NetworkImage(photoUrl),
                                        // ),
                                        // title: Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       Text(name),
                                        //       kHeight10,
                                        //       Text(age),
                                        //     ],
                                        //   ),
                                        // ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(15)),
                                              child: SizedBox(
                                                height: double.infinity,
                                                width: 13.h,
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child:
                                                      Image.network(photoUrl),
                                                ),
                                              ),
                                            ),
                                            kWidth20,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Name : '),
                                                    Text(name.capitalize!),
                                                  ],
                                                ),
                                                kHeight10,
                                                Row(
                                                  children: [
                                                    Text('Age : '),
                                                    Text(age),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (ctx, index) {
                                  return const SizedBox(
                                    height: 5,
                                  );
                                },
                                itemCount: snapshot.data!.length);
                      });
                },
              );
            } else {
              return ConnectionLost();
            }
          }),
    );
  }
}

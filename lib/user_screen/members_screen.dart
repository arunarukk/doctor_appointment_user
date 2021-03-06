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
        title: const Text(
          'Members',
          style: TextStyle(color: kBlack),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddMembers(
                              title: 'Add member',
                            )));
              },
              icon: const Icon(
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
            icon: const Icon(
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
                          return const SkeletonMember();
                        }
                        return snapshot.data == null || snapshot.data!.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:const [
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
                                physics: const BouncingScrollPhysics(),
                                controller: scrollController,
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                itemBuilder: (ctx, index) {
                                  final String name =
                                      snapshot.data![index].data()['userName'];
                                  final String age =
                                      snapshot.data![index].data()['age'];
                                  final String photoUrl =
                                      snapshot.data![index].data()['photoUrl'];
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
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    const Text('Name : '),
                                                    Text(name.capitalize!),
                                                  ],
                                                ),
                                                kHeight10,
                                                Row(
                                                  children: [
                                                    const Text('Age : '),
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
              return const ConnectionLost();
            }
          }),
    );
  }
}

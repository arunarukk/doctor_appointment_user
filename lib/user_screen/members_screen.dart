import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/add_member.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        body: StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: control.getMembers(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Center(
                      child: Text(
                        "No data",
                        style: TextStyle(color: kBlack),
                      ),
                    )
                  : ListView.separated(
                      controller: scrollController,
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      itemBuilder: (ctx, index) {
                        print(snapshot.data![index].data());
                        final String name =
                            snapshot.data![index].data()['userName'];
                        final String age = snapshot.data![index].data()['age'];
                        final String photoUrl =
                            snapshot.data![index].data()['photoUrl'];
                        return Card(
                          color: kWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            height: 100,
                            child: Center(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddMembers(
                                                title: 'Update',
                                                data: snapshot.data![index]
                                                    .data(),
                                                uid: snapshot.data![index].id,
                                              )));
                                },
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(photoUrl),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(name),
                                      kHeight10,
                                      Text(age),
                                    ],
                                  ),
                                ),
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
            }));
  }
}

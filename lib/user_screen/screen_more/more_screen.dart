import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_appointment/authentication_screen/log_in.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/models/patients_model.dart';
import 'package:doctor_appointment/user_screen/main_screen_home/main_home_screen.dart';
import 'package:doctor_appointment/user_screen/members_screen.dart';
import 'package:doctor_appointment/user_screen/screen_profile/profile_screen.dart';
import 'package:doctor_appointment/user_screen/widget/appbar_wiget.dart';
import 'package:doctor_appointment/user_screen/widget/connection_lost.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatelessWidget {
  final Uri _url = Uri.parse(
      'https://www.privacypolicies.com/live/865cfcc5-fe55-4100-af27-4b88bda6c477');

  MoreScreen({Key? key}) : super(key: key);

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  DateTimeRange? dateRange;
  @override
  Widget build(BuildContext context) {
    statecontrol.getUserProfileDetails();
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        appBar: const PreferredSize(
            child: AppBarWidget(title: 'More'),
            preferredSize: Size.fromHeight(60)),
        body: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.hasData &&
                      snapshot.data != ConnectivityResult.none) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              color: kBlue,
                              child: GetBuilder<StateController>(
                                  builder: (controller) {
                                return StreamBuilder<Patients>(
                                    stream: controller.getUserProfileDetails(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          height: 7.h,
                                          child: const Center(
                                            child: CupertinoActivityIndicator(
                                              color: kWhite,
                                            ),
                                          ),
                                        );
                                      }
                                      if (snapshot.data == null ||
                                          snapshot.data!.userName.isEmpty) {
                                        return Text(
                                          'Hola',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: kBlue,
                                          ),
                                        );
                                      }
                                      return ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProfileScreen()));
                                        },
                                        title: Text(
                                          snapshot.data!.userName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot.data!.photoUrl),
                                        ),
                                        trailing: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      );
                                    });
                              })),
                          SizedBox(height: 4.h),
                          const Text(
                            "Settings",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Members"),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_outlined),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MembersScreen()));
                            },
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("About"),
                            trailing: const Icon(Icons.info_outline),
                            onTap: () {
                              showAboutDialog(
                                context: context,
                                applicationName: 'Medoc',
                                applicationVersion: '1.0.0',
                                applicationIcon: Image.asset(
                                  'assets/medoc.png',
                                  width: 15.w,
                                ),
                              );
                            },
                          ),
                          ListTile(
                            onTap: () {
                              _launchUrl();
                            },
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Privacy Policy"),
                            trailing: const Icon(Icons.privacy_tip_outlined),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text('Logout'),
                            trailing: Icon(
                              Icons.logout_outlined,
                              color: kRed,
                            ),
                            onTap: () {
                              showMyDialog(context);
                            },
                          ),
                          const SizedBox(height: 60.0),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const ConnectionLost();
              }
            }),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(color: kRed),
          ),
          content: const Text('Do you want to logout ?'),
          actions: [
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                authC.signOut().then((value) {
                  MainHomeScreen.selectedIndexNotifier.value = 0;
                });
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                    (route) => false);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

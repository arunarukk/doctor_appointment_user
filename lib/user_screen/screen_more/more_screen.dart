import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_appointment/authentication_screen/log_in.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/members_screen.dart';
import 'package:doctor_appointment/user_screen/screen_profile/profile_screen.dart';
import 'package:doctor_appointment/user_screen/widget/Appoinment/make_appoinment.dart';
import 'package:doctor_appointment/user_screen/widget/appbar_wiget.dart';
import 'package:doctor_appointment/user_screen/widget/connection_lost.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant_value/constant_size.dart';
import '../widget/Appoinment/problem_screen.dart';

class MoreScreen extends StatelessWidget {
  // static final String path = "lib/src/pages/settings/settings1.dart";

//   @override
//   _SettingsOnePageState createState() => _SettingsOnePageState();
// }

// class _SettingsOnePageState extends State<MoreScreen> {
//   late bool _dark;

  // @override
  // void initState() {
  //   statecontrol.refreshUser();
  //   super.initState();
  //   _dark = false;
  // }

  // Brightness _getBrightness() {
  //   return _dark ? Brightness.dark : Brightness.light;
  // }

  final Uri _url = Uri.parse(
      'https://www.privacypolicies.com/live/865cfcc5-fe55-4100-af27-4b88bda6c477');

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  DateTimeRange? dateRange;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          // brightness: _getBrightness(),
          ),
      child: Scaffold(
        // backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: PreferredSize(
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
                                          child: Center(
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
                                                      ProfileScreen()));
                                        },
                                        title: Text(
                                          snapshot.data!.userName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot.data!.photoUrl),
                                        ),
                                        trailing: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      );
                                    });
                              })),
                          const SizedBox(height: 10.0),
                          // Card(
                          //   elevation: 4.0,
                          //   margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10.0)),
                          //   child: Column(
                          //     children: <Widget>[
                          //       ListTile(
                          //         leading: Icon(
                          //           Icons.lock_outline,
                          //           color: Colors.purple,
                          //         ),
                          //         title: Text("Change Password"),
                          //         trailing: Icon(Icons.keyboard_arrow_right),
                          //         onTap: () {
                          //           //open change password
                          //         },
                          //       ),
                          //       _buildDivider(),
                          //       ListTile(
                          //         leading: Icon(
                          //           Icons.language_outlined,
                          //           color: Colors.purple,
                          //         ),
                          //         title: Text("Change Language"),
                          //         trailing: Icon(Icons.keyboard_arrow_right),
                          //         onTap: () {
                          //           //open change language
                          //         },
                          //       ),
                          //       _buildDivider(),
                          //       ListTile(
                          //         leading: Icon(
                          //           Icons.location_on,
                          //           color: Colors.purple,
                          //         ),
                          //         title: Text("Change Location"),
                          //         trailing: Icon(Icons.keyboard_arrow_right),
                          //         onTap: () {
                          //           //open change location
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Settings",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          ListTile(
                            //  activeColor: Colors.purple,
                            contentPadding: const EdgeInsets.all(0),
                            //value: true,
                            title: Text("Members"),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MembersScreen()));
                            },
                          ),
                          ListTile(
                            //  activeColor: Colors.purple,
                            contentPadding: const EdgeInsets.all(0),
                            // value: false,
                            title: Text("About"),
                            trailing: Icon(Icons.info_outline),
                            //onChanged: null,

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
                            //activeColor: Colors.purple,
                            contentPadding: const EdgeInsets.all(0),
                            // value: true,
                            title: Text("Privacy Policy"),
                            trailing: Icon(Icons.privacy_tip_outlined),
                            // onChanged: (val) {},
                          ),

                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text('Logout'),
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
                    // Positioned(
                    //   bottom: -20,
                    //   left: -20,
                    //   child: Container(
                    //     width: 80,
                    //     height: 80,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //       color: kBlue,
                    //       shape: BoxShape.circle,
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 00,
                    //   left: 00,
                    //   child: IconButton(
                    //     icon: Icon(
                    //       Icons.power_off,
                    //       color: Colors.white,
                    //     ),
                    //     onPressed: () {
                    //       //log out
                    //     },
                    //   ),
                    // )
                  ],
                );
              } else {
                return ConnectionLost();
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
          content: Text('Do you want to logout ?'),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                authC.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                    (route) => false);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}

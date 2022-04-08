import 'package:doctor_appointment/authentication_screen/log_in.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/user_screen/members_screen.dart';
import 'package:doctor_appointment/user_screen/screen_profile/profile_screen.dart';
import 'package:doctor_appointment/user_screen/widget/appbar_wiget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  // static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<MoreScreen> {
  late bool _dark;

  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: PreferredSize(
            child: AppBarWidget(title: 'More'),
            preferredSize: Size.fromHeight(60)),
        body: Stack(
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
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      title: Text(
                        "Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/log_illu/Doctor-color-800px.png')),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
                    //onChanged: null,
                  ),
                  ListTile(
                    //activeColor: Colors.purple,
                    contentPadding: const EdgeInsets.all(0),
                    // value: true,
                    title: Text("Privacy Policy"),
                    // onChanged: (val) {},
                  ),
                  // SwitchListTile(
                  //   activeColor: Colors.purple,
                  //   contentPadding: const EdgeInsets.all(0),
                  //   value: true,
                  //   title: Text("Received App Updates"),
                  //   onChanged: null,
                  // ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text('Logout'),
                    trailing: Icon(Icons.logout_outlined),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()));
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
        ),
      ),
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
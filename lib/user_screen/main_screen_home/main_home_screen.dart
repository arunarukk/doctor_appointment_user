import 'package:doctor_appointment/user_screen/screen_appoinment/appointment_screen.dart';
import 'package:doctor_appointment/user_screen/screen_home/home_screen.dart';
import 'package:doctor_appointment/user_screen/screen_more/more_screen.dart';
import 'package:doctor_appointment/user_screen/screen_profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../widget/bottom_navigation.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final List<Widget> _pages = [
    const HomeScreen(),
    AppointmentScreen(),
    const ProfileScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NewBottomNavigationBar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: MainHomeScreen.selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
    );
  }
}

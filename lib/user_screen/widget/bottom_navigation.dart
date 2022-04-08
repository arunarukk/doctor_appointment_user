import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:doctor_appointment/user_screen/main_screen_home/main_home_screen.dart';
import 'package:flutter/material.dart';

class NewBottomNavigationBar extends StatelessWidget {
  const NewBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MainHomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavyBar(
          selectedIndex: updatedIndex,
          onItemSelected: (index) {
            MainHomeScreen.selectedIndexNotifier.value = index;
            //this.index = index;
          },
          items: [
            BottomNavyBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
              title: Text('Home'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent.shade700,
              inactiveColor: Colors.grey,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              title: Text('Appointment'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent.shade700,
              inactiveColor: Colors.grey,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person_outline),
              title: Text('Profile'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent.shade700,
              inactiveColor: Colors.grey,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.apps_outlined),
              title: Text('More'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent.shade700,
              inactiveColor: Colors.grey,
            ),
          ],
        );
      },
    );
  }
}

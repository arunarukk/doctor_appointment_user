import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // Future.delayed(Duration(seconds: 2));
    return Scaffold(
      body: Center(
          child: Container(
        width: 20.w,
        child: Image.asset('assets/medoc.png'),
      )),
    );
  }
}

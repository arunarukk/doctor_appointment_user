import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProblemScreen extends StatelessWidget {
  const ProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
         Scaffold(
      backgroundColor: kWhite.withOpacity(.2),
      //primary: false,
      extendBody: false,
      body: Center(
        child: Container(
          // alignment: Alignment.center,
          height: 50.h,
          width: 80.w,

          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                // key: _key,
                child: TextFormField(
                  // controller: disController,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Discription';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

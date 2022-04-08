import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/user_screen/widget/appbar_wiget.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:flutter/material.dart';

class SpecialityWiseDoctor extends StatelessWidget {
  SpecialityWiseDoctor({Key? key}) : super(key: key);

 final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Speciality',
          style: TextStyle(color: kBlack),
        ),
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
      body: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.only(left: 20, right: 20),
        itemBuilder: (ctx, index) {
          return DoctorList();
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 5,
          );
        },
        itemCount: 5,
      ),
    );
  }
}

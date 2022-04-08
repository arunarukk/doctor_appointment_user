import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_profile.dart';
import 'package:flutter/material.dart';

import '../../../constant_value/constant_size.dart';

class DoctorList extends StatelessWidget {
  DoctorList({
    Key? key,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors',
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
        //automaticallyImplyLeading: true,
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            mainAxisExtent: size * .21,
          ),
          controller: scrollController,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          itemBuilder: (ctx, index) {
            return Card(
              color: kBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SizedBox(
                //height: 200,
                // width: 50,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDetailScreen()));
                  },
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child: SizedBox(
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.asset('assets/lukman.jpeg')),
                          height: size * .14,
                          width: size * 1,
                        ),
                      ),
                     
                      kWidth20,
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Dr name',
                            style: TextStyle(color: kWhite),
                          ),
                          Text(
                            'ortho',
                            style: TextStyle(color: kWhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: 20),
    );
  }
}

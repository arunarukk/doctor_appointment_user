import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/user_screen/cancel_appoinment.dart';
import 'package:flutter/material.dart';

class AppointmentWidget extends StatelessWidget {
  AppointmentWidget({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 0),
            child: Container(
              // elevation: 2.5,
              // / color: kGrey,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: .2,
                    // spreadRadius: .1,
                    // blurStyle: BlurStyle.outer
                    // offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),

              child: SizedBox(
                height: 120,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CancelAppoinment()));
                  },
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(10)),
                        child: SizedBox(
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.asset('assets/lukman.jpeg')),
                          height: double.infinity,
                          width: size * .13,
                        ),
                      ),
                      // Container(
                      //   height: 90,
                      //   width: 80,
                      //   decoration: BoxDecoration(
                      //     // color: kBlue,
                      //     borderRadius: BorderRadius.circular(6.0),
                      //   ),
                      //   child:
                      //       Image.asset('assets/log_illu/Doctor-color-800px.png'),
                      // ),
                      kWidth20,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kHeight10,
                          Text('Dr name'),
                          kHeight10,
                          Text('ortho'),
                          kHeight10,
                          SizedBox(
                            width: size * .28,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 25,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: kBlue,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Center(child: Text('12/04/2022')),
                                  ),
                                  kWidth10,
                                  Container(
                                    height: 25,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: kBlue,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(child: Text('10:00')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          kHeight10
                        ],
                      ),
                    ],
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
        itemCount: 10);
  }
}

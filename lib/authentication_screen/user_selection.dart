import 'package:doctor_appointment/authentication_screen/log_in.dart';
import 'package:doctor_appointment/authentication_screen/sign_up.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:flutter/material.dart';

class UserSelection extends StatelessWidget {
  const UserSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 60, 39, 176),
              Color.fromARGB(255, 0, 255, 242)
            ])),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 10),
              child: Column(
                children: [
                  Image.asset('assets/doc_3d/doc(10).png'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Find the best doctors!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              width: 200,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                // border: Border(
                //     bottom: BorderSide(color: Theme.of(context).dividerColor)),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   width: 20,
                          //   child: Image.asset('assets/tick_cancel/tick.png'),
                          // ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: .6,
                      color: kBlack,
                    ),
                    InkWell(
                      onTap: () {
                        print('not a doctor');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   width: 20,
                          //   child: Image.asset('assets/tick_cancel/cancel.png'),
                          // ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   width: 200,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     // border: Border.all(color: Colors.black),
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(20.0),
            //         bottomRight: Radius.circular(20.0)),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

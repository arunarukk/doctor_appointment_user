import 'package:doctor_appointment/authentication_screen/otp_auth_screen.dart';
import 'package:doctor_appointment/authentication_screen/otp_verification_screen.dart';
import 'package:doctor_appointment/authentication_screen/sign_up.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:flutter/material.dart';

import '../user_screen/main_screen_home/main_home_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void logInPatient(BuildContext ctx) async {
    // control.loading(true);
    print(_emailController.text);
    print('patient login');
    String result = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (result == 'Success') {
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (ctx) => MainHomeScreen()));
      showSnackBar(result, kGreen, ctx);
      print("----------------$result");
    } else {
      showSnackBar(result, kRed, ctx);
    }
    // control.loading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 0, 162, 255),
              Color.fromARGB(255, 51, 19, 231)
            ])),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 8.0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200)),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   colors: [
                  //     Color.fromARGB(255, 165, 17, 42),
                  //     Color.fromARGB(255, 16, 211, 58)
                  //   ],
                  // ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 50),
                    child: SizedBox(
                      child: Image.asset(
                          'assets/log_illu/People-Search-color-800px.png'),
                    ),
                  ),
                  // Text(
                  //   'Log-In',
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50, top: 20),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 48, 150, 223),
                              //filled: true,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: 'E-mail',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),

                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: 0), // add padding to adjust icon
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50, top: 20, bottom: 20),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                //filled: true,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'Password',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      top: 0), // add padding to adjust icon
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: Colors.white,
                                    ))),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //       width: 200,
                        //       height: 50,
                        //       decoration: BoxDecoration(
                        //           gradient: LinearGradient(
                        //               begin: Alignment.topLeft,
                        //               end: Alignment.bottomRight,
                        //               colors: [
                        //                 Color.fromARGB(255, 212, 165, 33),
                        //                 Color.fromARGB(255, 212, 165, 33)
                        //               ]),
                        //           borderRadius: BorderRadius.circular(50)),
                        //       child: Center(
                        //           child: Text(
                        //         'Login',
                        //         style: TextStyle(
                        //             fontSize: 18, color: Colors.white),
                        //       ))),
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            logInPatient(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainHomeScreen()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 241, 187, 38),
                              fixedSize: const Size(300, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PhoneAuthentication()));
                            },
                            child: Text(
                              "Don't have an account? ",
                              style: TextStyle(color: kBlack),
                            )),

                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? "),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: Text('Register')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

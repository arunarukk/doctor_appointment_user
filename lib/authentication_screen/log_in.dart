import 'package:doctor_appointment/authentication_screen/otp_auth_screen.dart';
import 'package:doctor_appointment/authentication_screen/sign_up.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../user_screen/main_screen_home/main_home_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void logInPatient(BuildContext ctx) async {
    signControl.loading(true);
    signControl.update(['login']);
    String result = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (result == 'Success') {
      // Navigator.of(ctx).pushReplacement(
      //     MaterialPageRoute(builder: (ctx) => const MainHomeScreen()));
      Get.offAll(const MainHomeScreen());
      showSnackBar(result, kGreen, ctx);
      debugPrint("----------------$result");
    } else {
      showSnackBar(result, kRed, ctx);
    }
    signControl.loading(false);
    signControl.update(['login']);
  }

  @override
  Widget build(BuildContext context) {
    signControl.loadL = false;
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
                height: 55.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 8.0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200.h),
                      bottomRight: Radius.circular(200.h)),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 13.h, bottom: 8.h),
                    child: SizedBox(
                      child: Image.asset(
                        'assets/log_illu/login_screen.png',
                        width: 36.h,
                      ),
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 13.w, right: 13.w, top: 1.h),
                          child: TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: kWhite),
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 48, 150, 223),
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
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 13.w, right: 13.w, top: 3.h, bottom: 3.h),
                          child: GetBuilder<StateController>(
                            init: StateController(),
                            id: 'visiblity',
                            builder: (visible) {
                              return TextFormField(
                                obscureText: visible.passwordVisible,
                                controller: _passwordController,
                                style: const TextStyle(color: kWhite),
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    labelText: 'Password',
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: Colors.white,
                                        size: 5.w,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          if (visible.passwordVisible == true) {
                                            visible.passwordVisible = false;
                                          } else {
                                            visible.passwordVisible = true;
                                          }

                                          visible.update(['visiblity']);
                                        },
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Icon(
                                            visible.passwordVisible == true
                                                ? Icons.remove_red_eye_rounded
                                                : Icons.remove_red_eye_outlined,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ))),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            logInPatient(context);
                          },
                          child: GetBuilder<SignController>(
                              init: SignController(),
                              id: 'login',
                              builder: (login) {
                                return login.isLoading == true
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: kWhite,
                                        ),
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      );
                              }),
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 241, 187, 38),
                              fixedSize: const Size(300, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(color: kWhite),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PhoneAuthentication()));
                              },
                              child: const Text(
                                "Login with phone",
                                style: TextStyle(color: kWhite),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(color: kWhite),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()));
                                  },
                                  child: const Text(
                                    'Register here!',
                                    style: TextStyle(
                                        color: kWhite,
                                        decoration: TextDecoration.underline,
                                        decorationColor: kWhite,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        decorationThickness: 1.5),
                                  )),
                            ],
                          ),
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

import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../constant_value/constant_colors.dart';
import '../resources/auth_method.dart';
import '../user_screen/main_screen_home/main_home_screen.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({Key? key}) : super(key: key);

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController otpCodeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationIdRecieved = '';

  String otpPin = '';

  @override
  Widget build(BuildContext context) {
    signControl.loading(false);
    // signControl.otpCodeVisible = false;
    final size = MediaQuery.of(context).size.height;
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
                decoration: const BoxDecoration(
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0, bottom: 80),
                      child: SizedBox(
                        child: Image.asset(
                          'assets/log_illu/login_screen.png',
                          width: size * .36,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50.0, right: 50, top: 10),
                      child: TextFormField(
                        controller: phoneController,
                        style: TextStyle(color: kWhite),
                        //  inputFormatters: [],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 48, 150, 223),
                          //filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Phone number',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),

                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                top: 0), // add padding to adjust icon
                            child: Icon(
                              Icons.phone_android,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        validator: (value) {
                          String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    kHeight20,
                    GetBuilder<SignController>(
                      init: SignController(),
                      id: 'visible',
                      builder: (visible) {
                        return Visibility(
                          visible: visible.otpCodeVisible,
                          child: OTPTextField(
                            // controller: otpCodeController,
                            keyboardType: TextInputType.number,
                            length: 6,
                            width: size * .4,
                            fieldWidth: 40,
                            style: TextStyle(fontSize: 17, color: kWhite),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.underline,
                            otpFieldStyle: OtpFieldStyle(
                              borderColor: kWhite,
                              disabledBorderColor: kWhite,
                              enabledBorderColor: kWhite,
                              focusBorderColor: kWhite,
                              errorBorderColor: kRed,
                            ),
                            onChanged: (newpin) {
                              print(newpin);
                            },
                            onCompleted: (pin) {
                              print("Completed: " + pin);
                              otpPin = pin;
                            },
                          ),
                        );
                      },
                    ),
                    kHeight20,
                    GetBuilder<SignController>(
                      init: SignController(),
                      id: 'otp',
                      builder: (otpvi) {
                        return ElevatedButton(
                            onPressed: () {
                              if (otpvi.otpCodeVisible) {
                                verifyCode();
                              } else {
                                verifyNumber();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 241, 187, 38),
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: otpvi.isLoading!
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: kWhite,
                                  ))
                                : Text(
                                    otpvi.otpCodeVisible ? "Login" : "Verify",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyNumber() async {
    signControl.loading(true);
    signControl.update(['otp']);
    auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) => {
                print("your logged in successfully"),
              });
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationIdRecieved = verificationId;
          signControl.otpCodeVisible = true;
          signControl.update(['visible']);

          //setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
    await Future.delayed(Duration(seconds: 2));
    signControl.loading(false);
    signControl.update(['otp']);
  }

  void verifyCode() async {
    signControl.loading(true);
    signControl.update(['otp']);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdRecieved, smsCode: otpPin);
    await auth.signInWithCredential(credential).then((value) async {
      {
        User currentUser = auth.currentUser!;
        final data = await AuthMethods().getUserDetails();
        try {
          // if (currentUser.email == null) {
          //   print("current user emty otp sign");
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => LoginProfileScreen()));
          // }
          print("you are logged in successfully");
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => HomeScreen(),
          //   ),
          //   (route) => false,
          // );

          //  signControl.update(['otp']);
          if (data.userName != null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MainHomeScreen(),
              ),
              (route) => false,
            );
          } else {
            print('phone exist verify code');

            currentUser.delete();
          }
          signControl.loading(false);
          signControl.update(['otp']);
        } catch (e) {
          print('otp auth screen $e');
        }
      }
    });
  }
}

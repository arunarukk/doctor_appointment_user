import 'dart:typed_data';
import 'package:doctor_appointment/authentication_screen/log_in.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

import '../user_screen/main_screen_home/main_home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  // final OtpFieldController _otpController = OtpFieldController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationIdRecieved = '';

  String otpPin = '';

  final control = Get.put(SignController());

  bool passwordDisable = true;

  selectImage() async {
    try {
      Uint8List im = await pickImage(ImageSource.gallery);
      control.imageUpdate(im);
    } catch (e) {
      print('no image $e');
    }
  }

  void verifyNumber() async {
    control.loading(true);
    control.update(['checkbox']);
    if (_formKey.currentState!.validate()) {
      _auth.verifyPhoneNumber(
          phoneNumber: '+91${_phoneNumber.text}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential).then((value) => {
                  print('verifynumber${value.user!.uid}'),
                  print("your logged in successfully"),
                });
          },
          verificationFailed: (FirebaseAuthException exception) {
            print(exception.message);
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationIdRecieved = verificationId;
            signControl.otpCodeVisible = true;
            signControl.update(['otp']);
            control.update(['checkbox']);
            //setState(() {});
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    }
    await Future.delayed(Duration(seconds: 2));
    control.loading(false);
    control.update(['checkbox']);
  }

  void verifyCode(BuildContext ctx) async {
    PhoneAuthCredential cred = PhoneAuthProvider.credential(
        verificationId: verificationIdRecieved, smsCode: otpPin);
    //User currentUser = _auth.currentUser!;
    control.loading(true);
    control.update(['checkbox']);
    await _auth.signInWithCredential(cred).then((value) async {
      {
        try {
          print('verifycode ${value.user!.uid}');
          String result = await AuthMethods().otpSingUp(
            email: _emailController.text,
            uid: value.user!.uid,
            userName: _userNameController.text.toLowerCase(),
            phoneNumber: _phoneNumber.text,
            file: control.image!,
          );

          if (result != 'Success') {
            showSnackBar(result, kRed, ctx);
          }
          // Navigator.of(ctx).pushReplacement(
          //     MaterialPageRoute(builder: (ctx) => MainHomeScreen()));
          Navigator.of(ctx).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => MainHomeScreen()),
              (route) => false);
          showSnackBar(result, kGreen, ctx);
          print('otp login wit succes');
        } catch (e) {
          print('verifycode otp${e}');
        }
      }
    });
    await Future.delayed(Duration(seconds: 2));
    control.loading(false);
    control.update(['checkbox']);
  }

  void signUpPatient(BuildContext ctx) async {
    control.loading(true);
    if (control.image == null) {
      print('image is null');
      return;
    }
    if (_formKey.currentState!.validate()) {
      String result = await AuthMethods().signUpPatient(
        email: _emailController.text,
        password: _password.text,
        userName: _userNameController.text.toLowerCase(),
        phoneNumber: _phoneNumber.text,
        file: control.image!,
      );
      control.loading(false);
      if (result != 'Success') {
        showSnackBar(result, kRed, ctx);
      }
      Navigator.of(ctx)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => LogInScreen()));
      showSnackBar(result, kGreen, ctx);
    }
    // print('picture$_image');
  }

  @override
  Widget build(BuildContext context) {
    print('otp');
    signControl.otpCodeVisible = false;
    // control.loading(false);
    // final size = MediaQuery.of(context).size.height;
    //signControl.otpCodeVisible = false;
    // control.loading(false);
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 0, 162, 255),
                Color.fromARGB(255, 51, 18, 239)
              ]),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -10,
              left: -90,
              child: Container(
                height: 20.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(300),
                      bottomRight: Radius.circular(300)),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 200,
              child: Container(
                height: 18.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(300),
                      bottomRight: Radius.circular(300)),
                ),
              ),
            ),
            Positioned(
              top: -100,
              right: -40,
              child: Container(
                height: 33.h,
                width: 120.w,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(300),
                      bottomRight: Radius.circular(300)),
                ),
              ),
            ),
            Positioned(
              top: 680,
              right: -100,
              child: Container(
                height: 30.h,
                width: 60.w,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 153, 0),
                    borderRadius: BorderRadius.all(Radius.circular(200))),
              ),
            ),
            Positioned(
              top: 680,
              left: -100,
              child: Container(
                height: 30.h,
                width: 60.w,
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(200))),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 100.h,
                width: 100.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Stack(
                      children: [
                        GetBuilder<SignController>(
                          builder: ((controller) {
                            return control.image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage:
                                        MemoryImage(control.image!),
                                    backgroundColor: Colors.red,
                                  )
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://i.stack.imgur.com/l60Hf.png'),
                                    backgroundColor: Colors.red,
                                  );
                          }),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),

                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50.0, right: 50, top: 20),
                            child: TextFormField(
                              controller: _userNameController,
                              decoration: const InputDecoration(
                                fillColor: Color.fromARGB(255, 48, 150, 223),
                                //filled: true,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'User name',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),

                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      top: 0), // add padding to adjust icon
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50.0, right: 50, top: 10),
                            child: TextFormField(
                              controller: _phoneNumber,
                              //  inputFormatters: [],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
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
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50.0, right: 50, top: 10),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
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
                                    size: 16,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter E-mail';
                                } else if (!value.contains('@') ||
                                    !value.endsWith('.com')) {
                                  return 'Please enter a valid E-mail';
                                }
                                return null;
                              },
                            ),
                          ),
                          GetBuilder<SignController>(
                            init: SignController(),
                            id: 'otp',
                            builder: (otp) {
                              return Visibility(
                                visible: otp.otpCodeVisible,
                                child: OTPTextField(
                                  // controller: _otpController,
                                  keyboardType: TextInputType.number,
                                  length: 6,
                                  width: 40.h,
                                  fieldWidth: 40,
                                  style: TextStyle(fontSize: 17, color: kWhite),
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
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
                          GetBuilder<SignController>(
                            init: SignController(),
                            id: 'checkbox',
                            builder: (checkBox) {
                              return Column(
                                children: [
                                  Visibility(
                                    visible: !checkBox.otpLogin,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 50.0,
                                        right: 50,
                                        top: 10,
                                      ),
                                      child: TextFormField(
                                        enabled: passwordDisable,
                                        controller: _password,
                                        obscureText: true,
                                        style: TextStyle(color: kWhite),
                                        // keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            //filled: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            labelText: 'Password',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      0), // add padding to adjust icon
                                              child: Icon(
                                                Icons.lock_outline,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                            suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.remove_red_eye_rounded,
                                                  color: Colors.white,
                                                  size: 16,
                                                ))),
                                        validator: (value) {
                                          // RegExp regex =
                                          // RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                          RegExp regex = RegExp(
                                              r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter password';
                                          } else if (!regex.hasMatch(value)) {
                                            return 'Password must contain at least one lower case \nand one digit';
                                          }
                                          // else if (value.length < 8) {
                                          //   return 'Must be atleast 8 charater';
                                          // }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !checkBox.otpLogin,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50.0,
                                          right: 50,
                                          top: 10,
                                          bottom: 20),
                                      child: TextFormField(
                                        enabled: passwordDisable,
                                        controller: _confirmPassword,
                                        style: TextStyle(color: kWhite),
                                        obscureText: true,
                                        // keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            //filled: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            labelText: 'Confirm password',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      0), // add padding to adjust icon
                                              child: Icon(
                                                Icons.lock_outline,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                            suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.remove_red_eye_rounded,
                                                  color: Colors.white,
                                                  size: 16,
                                                ))),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              value != _password.text) {
                                            return "Password doesn't match";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50.0,
                                        right: 50,
                                        top: 10,
                                        bottom: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Login with phone number',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Checkbox(
                                          activeColor: kRed,
                                          value: checkBox.otpLogin,
                                          onChanged: (bool? value) {
                                            // print(value);
                                            passwordDisable = !value!;
                                            // print(passwordDisable);
                                            checkBox.otpLogin = value;
                                            checkBox.update(['checkbox']);
                                            // print(checkBox.otpLogin);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //signUpPatient(context);
                              if (signControl.otpLogin == false) {
                                signUpPatient(context);
                              } else {
                                if (signControl.otpCodeVisible) {
                                  verifyCode(context);
                                } else {
                                  verifyNumber();
                                }
                              }
                            },
                            child: GetBuilder<SignController>(
                              id: 'checkbox',
                              builder: (controller) {
                                return control.isLoading == true
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: kWhite,
                                        ),
                                      )
                                    : Text(
                                        controller.otpLogin == false
                                            ? "Login"
                                            : controller.otpCodeVisible
                                                ? "Login"
                                                : "verify",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      );
                              },
                            ),
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 241, 187, 38),
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: kWhite),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()));
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: kWhite),
                            )),
                      ],
                    ),
                    // SizedBox(
                    //   height: 200,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

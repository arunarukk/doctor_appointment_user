import 'package:doctor_appointment/authentication_screen/login_profile_screen.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/user_screen/screen_home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthentication extends StatefulWidget {
  PhoneAuthentication({Key? key}) : super(key: key);

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController otpCodeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationIdRecieved = '';

  bool otpCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Otp verification')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
              keyboardType: TextInputType.phone,
            ),
            kHeight20,
            Visibility(
              visible: otpCodeVisible,
              child: TextField(
                  controller: otpCodeController,
                  decoration: InputDecoration(labelText: 'code')),
            ),
            kHeight20,
            ElevatedButton(
                onPressed: () {
                  if (otpCodeVisible) {
                    verifyCode();
                  } else {
                    verifyNumber();
                  }
                },
                child: Text(otpCodeVisible ? "Login" : "verify")),
          ],
        ),
      ),
    );
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
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
          otpCodeVisible = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdRecieved,
        smsCode: otpCodeController.text);
    await auth.signInWithCredential(credential).then((value) {
      {
        User currentUser = auth.currentUser!;
        if (currentUser.email == null) {}
        print("you are logged in successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginProfileScreen()));
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => HomeScreen(),
        //   ),
        //   (route) => false,
        // );
      }
    });
  }
}

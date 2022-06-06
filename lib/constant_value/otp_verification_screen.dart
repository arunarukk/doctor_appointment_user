import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

class VerifyPhone extends StatefulWidget {
  VerifyPhone({Key? key}) : super(key: key);

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String? phone;

  @override
  Widget build(BuildContext context) {
    print('hello');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            authC.codeSent
                ? OTPTextField(
                    length: 6,
                    width: 100.w,
                    fieldWidth: 30,
                    style: TextStyle(fontSize: 20),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      authC.verifyOtp(pin, context);
                    },
                  )
                : IntlPhoneField(
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    initialCountryCode: 'IN',
                    onChanged: (phoneNumber) {
                      setState(() {
                        phone = phoneNumber.completeNumber;
                      });
                    },
                  ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  // final data = authC.getUserDetails();
                  // final phoneNumber = data.then((value) => value.phoneNumber);
                  authC.verifyPhone(phoneNumber: phone, context: context);
                },
                child: Text("Verify"))
          ],
        ),
      ),
    );
  }
}

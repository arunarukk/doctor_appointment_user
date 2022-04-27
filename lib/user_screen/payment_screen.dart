import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatelessWidget {
  final DateTime date;
  final String name;
  final String age;
  final String gender;
  final String problem;
  final String doctorId;
  final String phoneNum;
  final String photo;
  final String time;
  final String dateId;
  PaymentScreen(
      {Key? key,
      required this.date,
      required this.name,
      required this.age,
      required this.gender,
      required this.problem,
      required this.doctorId,
      required this.phoneNum,
      required this.photo,
      required this.time,
      required this.dateId})
      : super(key: key);

  late Razorpay razorpay;

  void openPayment({
    required dynamic phoneNumber,
    required dynamic email,
  }) {
    var options = {
      'key': 'rzp_test_1s4VSprSSqwOwT',
      'amount': 200 * 100,
      'name': 'Docotor Appoinment',
      'description': 'Payment for Consultation',
      'prefill': {
        'contact': phoneNumber,
        'eamil': email,
      },
      'external': {
        'wallet': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    razorpay = Razorpay();
    void handlerPaymentSuccess(PaymentSuccessResponse response) async {
      print('Payment success');
      final patient = authC.getUserDetails();

      final patientId = await patient.then((value) => value.uid);

      authC.bookAppoint(
        name: name,
        patientId: patientId,
        doctorId: doctorId,
        gender: gender,
        date: date,
        phoneNumber: phoneNum,
        age: age,
        problem: problem,
        payment: 'razorpay',
        time: time,
        photoUrl: photo,
        dateID: dateId,
      );
    }

    void handlerErrorFailure(PaymentFailureResponse response) {
      print('payment error');
    }

    void handlerExternalWallet(ExternalWalletResponse response) {
      print('External wallet');
    }

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirm Appoinment',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //kHeight20,
          Stack(
            children: [
              Center(
                child: Container(
                  height: 220,
                  width: 380,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 245, 36, 36),
                        Color.fromARGB(255, 245, 105, 95)
                      ])),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kWidth20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          kHeight30,
                          Text(
                            'Make Payment',
                            style: TextStyle(
                                fontSize: 18,
                                color: kBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          kHeight30,
                          Text(
                            '**** **** **** ****',
                            style: TextStyle(
                                fontSize: 18, color: kBlack, letterSpacing: 1),
                            textScaleFactor: 1.2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              '₹ 300',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: kWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      // kWidth10,
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 15),
                        child: Container(
                          // color: kWhite,
                          width: 150,
                          height: 25,
                          child: Image.asset('assets/razorpay.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, bottom: 10),
              child: Text(
                'Mode of payment',
                style: TextStyle(
                    fontSize: 18, color: kBlack, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                kHeight20,
                ElevatedButton(
                  onPressed: () async {
                    print('pay on hand');
                    String payment = 'Pay on hand';
                    final patient = authC.getUserDetails();

                    final patientId = await patient.then((value) => value.uid);

                    // final phoneNumber =
                    //     await patient.then((value) => value.phoneNumber);

                    authC.bookAppoint(
                      name: name,
                      patientId: patientId,
                      doctorId: doctorId,
                      gender: gender,
                      date: date,
                      phoneNumber: phoneNum,
                      age: age,
                      problem: problem,
                      payment: payment,
                      time: time,
                      photoUrl: photo,
                      dateID: dateId,
                    );
                  },
                  //icon: Icon(Icons.handshake_outlined),
                  child: Text(
                    '🤝 Pay on hand',
                    style: TextStyle(
                        fontSize: 18,
                        color: kWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 18),
                      primary: kBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                kHeight30,
                ElevatedButton(
                  onPressed: () async {
                    final patient = authC.getUserDetails();
                    final email = await patient.then((value) => value.email);
                    openPayment(
                      email: email,
                      phoneNumber: phoneNum,
                    );
                  },
                  child: Container(
                    // color: kWhite,
                    width: 130,
                    height: 20,
                    child: Row(
                      children: [
                        Text('  💳  '),
                        Image.asset('assets/razorpay.png')
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 18),
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

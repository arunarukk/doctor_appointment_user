import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

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
    required BuildContext context,
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
      showSnackBar('Appointment booked successfully', kGreen, context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    razorpay = Razorpay();
    void handlerPaymentSuccess(PaymentSuccessResponse response) async {
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
      debugPrint('payment error');
    }

    void handlerExternalWallet(ExternalWalletResponse response) {
      debugPrint('External wallet');
    }

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm Appointment',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kBlack,
            )),
      ),
      body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasData && snapshot.data != ConnectivityResult.none) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(10 / 360),
                        child: Container(
                            height: 28.h,
                            width: 95.w,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: kBlack.withOpacity(.7),
                            )),
                      )),
                      Positioned(
                          //left: 80,
                          child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-10 / 360),
                        child: Container(
                            height: 28.h,
                            width: 95.w,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: kBlue.withOpacity(.7),
                            )),
                      )),
                      Container(
                        height: 28.h,
                        width: 95.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 245, 36, 36),
                              Color.fromARGB(255, 245, 105, 95)
                            ])),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kWidth20,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kHeight20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Make Payment',
                                      style:  TextStyle(
                                          fontSize: 18,
                                          color: kWhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 70),
                                      child: Container(
                                        // color: kWhite,
                                        width: 35.w,
                                        height: 4.h,
                                        child:
                                            Image.asset('assets/razorpay.png'),
                                      ),
                                    ),
                                  ],
                                ),
                                kHeight10,
                                Container(
                                  height: 7.h,
                                  child: Image.asset('assets/atmchip.png'),
                                ),
                                const Text(
                                  '**** **** **** ****',
                                  style:  TextStyle(
                                      fontSize: 24,
                                      color: kBlack,
                                      letterSpacing: 1),
                                  textScaleFactor: 1.2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: 42.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '₹ 300',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: kWhite,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 10.h,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                right: 0,
                                                child: Container(
                                                  height: 6.h,
                                                  width: 12.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //left: 1,
                                                child: Container(
                                                  height: 6.h,
                                                  width: 12.w,
                                                  decoration: BoxDecoration(
                                                    color: kBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                         ],
                        ),
                      ),
                    ],
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, left: 10, bottom: 10),
                      child: Text(
                        'Mode of payment',
                        style:  TextStyle(
                            fontSize: 18,
                            color: kBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        kHeight20,
                        ElevatedButton(
                          onPressed: () async {
                            String payment = 'Pay on hand';
                            final patient = authC.getUserDetails();

                            final patientId =
                                await patient.then((value) => value.uid);

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
                            showSnackBar('Appoinment booked successfully',
                                kGreen, context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '🤝 Pay on hand',
                            style: TextStyle(
                                fontSize: 18,
                                color: kWhite,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 16),
                              primary: kBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                        kHeight30,
                        ElevatedButton(
                          onPressed: () async {
                            final patient = authC.getUserDetails();
                            final email =
                                await patient.then((value) => value.email);
                            openPayment(
                                email: email,
                                phoneNumber: phoneNum,
                                context: context);

                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 130,
                            height: 20,
                            child: Row(
                              children: [
                                const Text('  💳  '),
                                Image.asset('assets/razorpay.png')
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 16),
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container(
                height: 100.h,
                width: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/error.gif',
                      // scale: .002,
                      width: 20.h,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text('Check your connection!'),
                  ],
                ),
              );
            }
          }),
    );
  }
}

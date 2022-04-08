import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Make Appoinment',
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
        children: [
          kHeight20,
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
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10, bottom: 10),
            child: Text(
              'Mode of payment',
              style: TextStyle(
                  fontSize: 16, color: kBlack, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Column(
              children: [
                kHeight20,
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen()));
                  },
                  //icon: Icon(Icons.handshake_outlined),
                  child: Text(
                    '🤝 Pay on hand',
                    style: TextStyle(
                        fontSize: 17,
                        color: kWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 10),
                      primary: kBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                kHeight30,
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen()));
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
                          horizontal: 60, vertical: 10),
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

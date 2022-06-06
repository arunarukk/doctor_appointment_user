import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConnectionLost extends StatelessWidget {
  const ConnectionLost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Container(
      height: 8.h,
      width: 100.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error.gif',
            // scale: .002,
            width: 2.h,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text('Check your connection!'),
        ],
      ),
    );
  }
}

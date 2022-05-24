import 'package:flutter/material.dart';

class ConnectionLost extends StatelessWidget {
  const ConnectionLost({
    Key? key,
    
  }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size.height;
    return Container(
      height: size * .8,
      width: size * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error.gif',
            // scale: .002,
            width: size * .2,
          ),
          SizedBox(
            height: size * .02,
          ),
          Text('Check your connection!'),
        ],
      ),
    );
  }
}

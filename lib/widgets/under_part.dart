import 'package:flutter/material.dart';

import '../../helper/constants.dart';

class UnderParat extends StatelessWidget {
  final String titele;
  final String navigatorText;
  final Function()? tap;
  const UnderParat({Key? key, required this.titele, required this.navigatorText,  this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          titele,
          style:  TextStyle(
              color: primaryColor,
              fontFamily: 'OpenSans',
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(width:10),
        GestureDetector(
          onTap: tap,
          child: Text(
            navigatorText,
            style: TextStyle(
                color: lightColor,
                fontFamily: 'OpenSans',
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.w600)
          ),
        )
      ],
    );
  }
}
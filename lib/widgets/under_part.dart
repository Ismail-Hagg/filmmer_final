import 'package:flutter/material.dart';

import '../../helper/constants.dart';

class UnderParat extends StatelessWidget {
  final String titele;
  final String navigatorText;
  final Function()? tap;
  const UnderParat({Key? key, required this.titele, required this.navigatorText,  this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          titele,
          style: const TextStyle(
              color: primaryColor,
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(width:10),
        GestureDetector(
          onTap: tap,
          child: Text(
            navigatorText,
            style:const TextStyle(
                color: lightColor,
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.w600)
          ),
        )
      ],
    );
  }
}
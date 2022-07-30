import 'package:filmmer_final/controllers/auth_cocontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constants.dart';
import 'custom_text.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color? textColor;
  const RoundButton(
      {Key? key, required this.text, this.press, this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
              primary: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: TextStyle(
                letterSpacing: 2,
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              )),
          child: Obx(
            () => Get.find<AuthController>().count == 1
                ? const CircularProgressIndicator(
                    color: lightColor,
                  )
                : CustomText(text: text, color: textColor, size: 17),
          ),
        ),
      ),
    );
  }
}

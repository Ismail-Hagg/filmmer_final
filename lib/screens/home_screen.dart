import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_cocontroller.dart';
import '../widgets/custom_text.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: GestureDetector(
          onTap: ()=>Get.find<AuthController>().signOut(),
          child: CustomText(
            text: 'Home Screen',
            size: 30,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
import 'package:filmmer_final/controllers/auth_cocontroller.dart';
import 'package:filmmer_final/screens/home_screen.dart';
import 'package:filmmer_final/screens/login_screen.dart';
import 'package:filmmer_final/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


//if user is logged in it goes to home screen , otherwise it goes to the login screen

class ControllScreen extends StatelessWidget {
  ControllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.find<AuthController>(),
      builder: (controller) =>
          controller.user == null ? LoginScreen() : HomeScreen(),
    );
  }
}
 
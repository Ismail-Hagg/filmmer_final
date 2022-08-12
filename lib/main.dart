import 'package:filmmer_final/screens/controll_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/auth_cocontroller.dart';
import 'controllers/connectivity_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ConnectivityController());
  Get.put(AuthController());
  runApp(const Filmmer()); 
  
}

class Filmmer extends StatelessWidget {
  const Filmmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Filmmer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ControllScreen(),
    );
  }
}
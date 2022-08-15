import 'package:filmmer_final/screens/controll_screen.dart';
import 'package:filmmer_final/storage_local/user_data.dart';
import 'package:filmmer_final/translation/reanslation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'controllers/auth_cocontroller.dart';
import 'controllers/connectivity_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ConnectivityController());
  Get.put(AuthController());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
        UserData().getLan.then((value) {
          if (value['lan']==null) {
            runApp(const Filmmer(map:  {'lan':'ar','country':'SA'},));
          } else {
            runApp(Filmmer(map: value,));
          }
        });
  });
}

class Filmmer extends StatelessWidget {
  final Map<String,String> map;
   const Filmmer({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocaleString(),
      locale:  Locale(map['lan'].toString(), map['country'].toString()),
      fallbackLocale: Get.deviceLocale,
      title: 'Filmmer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ControllScreen(),
    );
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filmmer_final/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../storage_local/user_data.dart';
import 'home_controller.dart';

class SettingsController extends GetxController {

  
  int counter=0;
  File? _image;
  File? get image => _image;
  dynamic path = '';
  String name='';
  String email='';

  change(String lan, String country) {
    print(lan);
    print(country);
    Get.back();
    Get.updateLocale(Locale(lan, country));
    UserData().setLan(lan, country);
    Get.find<HomeController>().load();
  }
  

   Future<void> openImagePicker() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);

    if (result == null) {
      print('nothing man');
    } else {
      path = result.files.single.path;
      _image = File(path.toString());

      UserData().getUser.then((value)async{
        UserModel model = value;
        model.isLocal=true;
        model.pic=path;
        name=model.name;
        email=model.email;
        await FireStoreService().addUsers(model);
        await UserData().setUser(model);

        counter=1;
        update();
        snack('Picture Changed', '');
      });
      
    }
  }
}

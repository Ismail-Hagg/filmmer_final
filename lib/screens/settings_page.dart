import 'package:filmmer_final/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_cocontroller.dart';
import '../controllers/settings_controller.dart';
import '../helper/constants.dart';
import '../models/user_model.dart';
import '../storage_local/user_data.dart';
import '../widgets/circle_container.dart';
import '../widgets/custom_text.dart';

class Settings extends StatelessWidget {
   Settings({Key? key}) : super(key: key);
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title:  CustomText(
            text: 'settings'.tr,
            color: lightColor,
          ),
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
         
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.3,
                child: GetBuilder<SettingsController>(
                  init:Get.find<SettingsController>(),
                  builder:(controll)=> controll.counter==0? FutureBuilder(
                      future: UserData().getUser,
                      builder: (BuildContext context,
                          AsyncSnapshot<UserModel> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CircleContainer(
                            fit: BoxFit.cover,
                            link: snapshot.data!.pic,
                            textUp: snapshot.data!.name,
                            textDown: snapshot.data!.email,
                            colorUp: whiteColor,
                            colorDown: whiteColor,
                            sizeUp: constraints.maxHeight * 0.02,
                            sizeDown: constraints.maxHeight * 0.015,
                            isLocal: snapshot.data!.isLocal,
                            color: whiteColor,
                            width: constraints.maxHeight * 0.2,
                            height: constraints.maxHeight * 0.2,
                            borderColor: lightColor,
                            borderWidth: 2,
                            spaceUp: constraints.maxHeight * 0.01,
                          );
                        } else {
                          return const Center(
                              child:
                                  CircularProgressIndicator(color: lightColor));
                        }
                      }):CircleContainer(
                            fit: BoxFit.cover,
                            link: controll.path,
                            textUp: controll.name,
                            textDown: controll.email, 
                            colorUp: whiteColor,
                            colorDown: whiteColor,
                            sizeUp: constraints.maxHeight * 0.02,
                            sizeDown: constraints.maxHeight * 0.015,
                            isLocal: true,
                            color: whiteColor,
                            width: constraints.maxHeight * 0.2,
                            height: constraints.maxHeight * 0.2,
                            borderColor: lightColor,
                            borderWidth: 2,
                            spaceUp: constraints.maxHeight * 0.02,
                          ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.7,
                child: Card(
                  color:mainColor,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            leading: const Icon(Icons.photo, color: lightColor),
                            title:  CustomText(
                              size: constraints.maxWidth * 0.04,
                                text: "changepic".tr, color: whiteColor),
                            onTap: ()=> controller.openImagePicker()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            leading:
                                const Icon(Icons.language, color: lightColor),
                            title: CustomText(
                              size: constraints.maxWidth * 0.04,
                                text: "changelanguage".tr, color: whiteColor),
                            onTap: () {
                              Get.defaultDialog(
                                title: 'lans'.tr,
                                content:Column(
                                  children:[
                                    ListTile(
                                      onTap: ()=> controller.change('en', 'US'),
                                      title:  CustomText(
                                        size: constraints.maxWidth * 0.04,
                                        text: "en".tr,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: ()=> controller.change('ar', 'SA'),
                                      title:  CustomText(
                                        size: constraints.maxWidth * 0.04,
                                        text: "ar".tr,
                                      ),
                                    )
                                  ]
                                )
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            leading: const Icon(Icons.logout, color: lightColor),
                            title:  CustomText(
                              size: constraints.maxWidth * 0.04,
                                text: "logout".tr, color: whiteColor),
                            onTap: () {
                              Get.defaultDialog(
                                title: '',
                                content: Column(
                                  children: [
                                    CustomText(text:"logoutq".tr,size: constraints.maxWidth * 0.04),
                                    TextButton(onPressed: (){
                                      Get.find<AuthController>().signOut();
                                    }, child:  CustomText(text: "answer".tr,size: constraints.maxWidth * 0.04,color: lightColor,))
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }));
  }
}

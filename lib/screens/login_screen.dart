import 'package:filmmer_final/controllers/auth_cocontroller.dart';
import 'package:filmmer_final/screens/signup_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../helper/constants.dart';
import '../widgets/circle_container.dart';
import '../widgets/custom_text.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_icon.dart';
import '../widgets/rounded_input.dart';
import '../widgets/under_part.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: (size.height - topPadding ),
          color: Colors.green,
          child: Stack(
            children: [
          Container(
              color: primaryColor,
              height: (size.height - topPadding) * 0.5,
              child: const Center(
                child: Icon(
                  Icons.movie_rounded,
                  color: lightColor,
                  size: 100,
                ),
              )),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: (size.height - topPadding) * 0.6,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   SizedBox(height: size.height*0.01),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    RoundedIcon(
                      imageUrl: 'assets/images/google.jpg',
                      tap: () {
                        controller.googleSignInMethod();
                      },
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                     RoundedIcon(imageUrl: 'assets/images/twitter.png',tap:()=> controller.support(),),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                     RoundedIcon(imageUrl: 'assets/images/facebook.png',tap:()=> controller.support()),
                  ]),
                   SizedBox(
                    height: size.height*0.02,
                  ),
                   CustomText(
                      text: 'emailuse'.tr,
                      color: primaryColor,
                      size: 14,
                      weight: FontWeight.w600),
                  Form(
                      key: _key,
                      child: Column(
                        children: [ 
                          RoundedInputField(
                            isEmail: TextInputType.emailAddress,
                            isPass: false,
                            hint: 'email'.tr,
                            icon: Icons.email,
                            sav: (value) {
                              controller.email = value.toString();
                            },
                          ),
                          Obx(
                            () => RoundedInputField(
                              lead: IconButton(
                                  onPressed: () {
                                    controller.obscureChange();
                                  },
                                  icon: const Icon(Icons.visibility,
                                      color: lightColor)),
                              isPass: controller.obscure.value,
                              hint: 'pass'.tr,
                              icon: Icons.lock,
                              sav: (value) {
                                controller.password = value.toString();
                              },
                            ),
                          ),
                          RoundButton(
                              textColor: lightColor,
                              text: 'login'.tr,
                              press: () { 
                                _key.currentState!.save();
                                controller.login(context);
                              }),
                              const SizedBox(height: 5,),
                              UnderParat(
                                titele: 'account'.tr,
                                navigatorText: 'make'.tr,
                                tap: (){
                                  Get.to(()=> SignUpScreen());
                                },
                              ),
                               SizedBox(height: size.height*0.01,),
                              
                        ],
                      ))
                ],
              ),
            ),
          )
            ],
          ),
        ),
      ),
    ));
  }
}

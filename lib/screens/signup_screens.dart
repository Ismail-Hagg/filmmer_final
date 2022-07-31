import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_cocontroller.dart';
import '../helper/constants.dart';
import '../widgets/circle_container.dart';
import '../widgets/custom_text.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_input.dart';
import '../widgets/under_part.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              color: Colors.green,
              width: size.width,
              height: (size.height - topPadding),
              child: Stack(children: [
                Container(
                    color: primaryColor,
                    height: (size.height - topPadding) * 0.3,
                    child: const Center()),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    height: (size.height - topPadding) * 0.8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: ((size.height - topPadding) * 0.8) * 0.03,
                        ),
                        child: GetBuilder<AuthController>(
                          init: Get.find<AuthController>(),
                          builder:(controller)=> GestureDetector(
                            onTap:()=>controller.openImagePicker(),
                            child: CircleContainer(
                              image:controller.image==null?
                               const DecorationImage(
                                image: AssetImage('assets/images/user.png'),
                               // fit: BoxFit.contain,
                                scale:0.7
                              ):
                              DecorationImage(
                                image:FileImage(controller.image!),
                                fit: BoxFit.cover,
                              ),
                              borderColor:lightColor,
                              borderWidth:2,
                              height: ((size.height - topPadding) * 0.8) * 0.25,
                              width: ((size.height - topPadding) * 0.8) * 0.25,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: ((size.height - topPadding) * 0.8) * 0.5,
                          child: Form(
                            key: _key,
                            child: Column(
                              children: [
                                RoundedInputField(
                                  hint: 'name',
                                  icon: Icons.person,
                                  isPass: false,
                                  sav: (value) {
                                    controller.name = value.toString();
                                  },
                                ),
                                RoundedInputField(
                                  isEmail: TextInputType.emailAddress,
                                  hint: 'Email',
                                  icon: Icons.email,
                                  isPass: false,
                                  sav: (value) {
                                    controller.email = value.toString();
                                  },
                                ),
                                RoundedInputField(
                                  hint: 'Password',
                                  icon: Icons.lock,
                                  isPass: false,
                                  sav: (value) {
                                    controller.password = value.toString();
                                  },
                                ),
                                RoundButton(
                                    textColor: lightColor,
                                    text: 'Register',
                                    press: () {
                                      _key.currentState!.save();
                                      controller.register(context);
                                    }),
                              ],
                            ),
                          )),
                      Container(
                          height: ((size.height - topPadding) * 0.8) * 0.19,
                          child: Center(
                            child: UnderParat(
                              titele: 'Already Have An Account?',
                              navigatorText: 'Login',
                              tap: () {
                                Get.back();
                              },
                            ),
                          ))
                    ]),
                  ),
                )
              ])),
        ),
      ),
    );
  }
}

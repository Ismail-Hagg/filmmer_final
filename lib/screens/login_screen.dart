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
      child: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
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
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.4),
              child: Container(
                width: size.width,
                height: (size.height - topPadding) * 0.5,
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
                      const RoundedIcon(imageUrl: 'assets/images/twitter.png'),
                      SizedBox(
                        width: size.width * 0.065,
                      ),
                      const RoundedIcon(imageUrl: 'assets/images/facebook.png'),
                    ]),
                     SizedBox(
                      height: size.height*0.02,
                    ),
                    const CustomText(
                        text: 'or use your email adress',
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
                              hint: 'Email',
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
                                hint: 'Password',
                                icon: Icons.lock,
                                sav: (value) {
                                  controller.password = value.toString();
                                },
                              ),
                            ),
                            RoundButton(
                                textColor: lightColor,
                                text: 'LOGIN',
                                press: () { 
                                  _key.currentState!.save();
                                  controller.login(context);
                                }),
                                const SizedBox(height: 5,),
                                UnderParat(
                                  titele: 'Dont Have An Account?',
                                  navigatorText: 'Register Here',
                                  tap: (){
                                    Get.to(()=> SignUpScreen());
                                  },
                                ),
                                 SizedBox(height: size.height*0.01,),
                                UnderParat(
                                  titele: '',
                                  navigatorText: 'Forgot Password',
                                  tap: (){
                                   // Get.to(()=> RegisterScreening());
                                  },
                                )
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    ));
  }
}

import 'package:flutter/material.dart';

import '../helper/constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
        child:Container(
          width: size.width,
              height: size.height,
              child: SingleChildScrollView(
                child: Stack(
                  children:[
                    Container(
                    color: primaryColor,
                    height: (size.height - topPadding) * 0.5,
                    child: const Center()
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.2),
                      child: Container(
                         width: size.width,
                height: (size.height - topPadding) * 0.5,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                      ),
                    )
                  ]
                ),
              )
        ) ,
      ),
    );
  }
}
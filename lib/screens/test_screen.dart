import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/movie_detale_controller.dart';
import '../widgets/custom_text.dart';

class Testing extends StatelessWidget {
  final String thing;
  Testing({Key? key, required this.thing}) : super(key: key);
  //final MovieDetaleController controller = Get.put(MovieDetaleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          child:  GetBuilder<MovieDetaleController>(
            init:Get.put(MovieDetaleController()),
            builder:(controller)=> GestureDetector(
              onTap:(){
                print('moving on');  
                //Get.back();
                Get.to(()=>Testing(thing:'other thing'), preventDuplicates: false);
              },
              child:  CustomText(
                    text:
                         thing,
                    flow: TextOverflow.ellipsis,
                  ),
            ),
          )),
    ));
  }
}

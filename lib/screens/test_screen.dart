import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';
import '../services/home_screen_service.dart';
import '../widgets/custom_text.dart';

class Testing extends StatelessWidget {
  final String thing;
  Testing({Key? key, required this.thing}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var count=0.obs;
    return Scaffold(
        body: Center(
      child: Container(
          child: GetBuilder<MovieDetaleController>(
        init: Get.put(MovieDetaleController()),
        builder: (controller) => GestureDetector(
          onTap: () async {
            Get.to(()=>Testing(thing:count.toString()), preventDuplicates: false);
            count++;
          },
          child: Obx(()=>
             CustomText(
              text: count.value.toString(),
              flow: TextOverflow.ellipsis,
            ),
          ),
        ),
      )),
    ));
  }
}

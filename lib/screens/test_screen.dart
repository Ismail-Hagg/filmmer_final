import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';
import '../services/home_screen_service.dart';
import '../widgets/custom_text.dart';

class Testing extends StatelessWidget {
  final String thing;
  Testing({Key? key, required this.thing}) : super(key: key);
  //final MovieDetaleController controller = Get.put(MovieDetaleController());
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
            print('moving on');
            //Get.back();
            Get.to(()=>Testing(thing:count.toString()), preventDuplicates: false);
            count++;
            // await FirstPageService().getHomeTopMovies(topTv).then((value) => {
            //   print(value.results![0].title)
            // });
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

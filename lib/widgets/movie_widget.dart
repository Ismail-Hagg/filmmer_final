import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmmer_final/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/movie_model.dart';
import 'custom_text.dart';

class MovieWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final String? link;
  final String? rating;
  const MovieWidget({Key? key, this.width, this.height, this.color, this.link, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
             GetBuilder<HomeController>(
              init: Get.find<HomeController>(),
               builder: (controlling)=>Container(
                width: width??0,
                height: height??0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: color??Colors.transparent),
                    image: DecorationImage(
                      image: link![0]=='h'? CachedNetworkImageProvider(
                        link.toString()
                      ) :AssetImage(link.toString()) as ImageProvider,
                      fit: BoxFit.cover,
                    ) 
                    ),
                         ),
             ),
          Get.find<HomeController>().coming.value.results!.isNotEmpty?
          Positioned(
              top: 5,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: CustomText(text: rating??'', color: Colors.white, size: 18),
              )):Container()
        ]),
      ],
    );
  }
}
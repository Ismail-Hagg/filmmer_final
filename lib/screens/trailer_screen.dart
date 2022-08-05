import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../controllers/trailer_controller.dart';

class TrailerScreen extends StatelessWidget {
   TrailerScreen({Key? key}) : super(key: key);

  final TrailerController controller = Get.put(TrailerController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Container(
              height:size.height*0.3,
              child: YoutubePlayerIFrame(
    controller: controller.controller,
),
            )
          ]
        ),
      )
    );
  }
}
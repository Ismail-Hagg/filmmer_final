import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

import '../models/trailer_model.dart';
import 'home_controller.dart';
import 'movie_detale_controller.dart';

class TrailerController extends GetxController {
  late final PodPlayerController controller;

  List<Trail> lst = [];
  String vid = '';
  String title = '';

  @override
  void onInit() {

    looping(Get.find<HomeController>().trailer.results as List<Trail>);
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
          'https://www.youtube.com/watch?v=$vid'),
          podPlayerConfig: const PodPlayerConfig(
            initialVideoQuality: 720,
            forcedVideoFocus: true

          )
    )..initialise();
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  //filter out videos that are not trailers
  looping(List<Trail> list) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].type == 'Trailer') {
        lst.add(list[i]);
      }
    }
    vid = list[list.length - 1].key.toString();
    title = list[list.length - 1].name.toString();
  }

  //change the video
  change(String id, String name) { 
    vid = id;
    title = name;
    controller.changeVideo(  playVideoFrom: PlayVideoFrom.youtube(
                    "https://www.youtube.com/watch?v=$id"));
    update();
  }
}

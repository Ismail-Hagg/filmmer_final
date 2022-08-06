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
    )..initialise();
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
  looping(List<Trail> list) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].type == 'Trailer') {
        print(list[i].name);
        lst.add(list[i]);
      }
    }
    vid = list[list.length - 1].key.toString();
    title = list[list.length - 1].name.toString();
  }

  change(String id, String name) { 
    vid = id;
    title = name;
    controller.changeVideo(  playVideoFrom: PlayVideoFrom.youtube(
                    "https://www.youtube.com/watch?v=$id"));
    print('done and done');
    update();
  }
}

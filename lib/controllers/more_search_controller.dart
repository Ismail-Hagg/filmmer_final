import 'package:filmmer_final/models/more_search_moving.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../models/movie_result_model.dart';
import '../services/home_screen_service.dart';
import 'home_controller.dart';

class MoreSearchController extends GetxController {
  Move move = Get.find<HomeController>().move;
  HomeTopMovies model = HomeTopMovies();
  int count = 1;
  String query = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firstLoad();
  }

  getMovies(int page) async {
    await FirstPageService()
        .getHomeTopMovies('${move.link}&page=$page')
        .then((value) => {model = value});
    update();
  }

  firstLoad() {
    if (move.isSearch == false) {
      getMovies(count);
    }
  }

  //next page
  nextPage(int last) async {
    if (count == 10) {
      count = 1;
      getMovies(count);
    } else if (count == last) {
      Get.snackbar('Last Page', '');
    } else {
      count++;
      getMovies(count);
    }
  }

  //previous page
  prePage() async {
    if (count == 1) {
      count = 10;
      getMovies(count);
    } else {
      count--;
      getMovies(count);
    }
  }

  //search
  search(int page) async {
    var lnk =
        'https://api.themoviedb.org/3/search/multi?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US&query=$query&page=$page';
    await FirstPageService().getHomeTopMovies(lnk).then((value) => {
          model = value,
          if (model.totalPages == 0)
            {
              count = 0,
              Get.snackbar(
                '',
                'No Results',
                backgroundColor: lightColor,
                colorText: whiteColor,
              )
            }
          else if (model.totalPages! < page)
            {
              Get.snackbar('', 'No More Results',
                  backgroundColor: lightColor, colorText: whiteColor)
            }
        });

    update();
  }

  searchUp(String way, int last) {
    if (way == 'up') {
      if (count != last) {
        count++;
        search(count);
      } else {
        Get.snackbar('', 'No More Results',
            backgroundColor: lightColor, colorText: whiteColor);
      }
    } else {
      if (count == 1) {
      } else {
        count--;
        search(count);
      }
    }
  }
}

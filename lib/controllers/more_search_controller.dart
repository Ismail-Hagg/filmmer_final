import 'package:filmmer_final/models/more_search_moving.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../models/movie_result_model.dart';
import '../services/home_screen_service.dart';
import '../storage_local/user_data.dart';
import 'home_controller.dart';

class MoreSearchController extends GetxController {
  Move move = Get.find<HomeController>().move;
  HomeTopMovies model = HomeTopMovies();
  int count = 1;
  String query = '';
  int indicator = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firstLoad();
  }

  getMovies(int page) async {
    model = HomeTopMovies();
    indicator=1;
    await FirstPageService()
        .getHomeTopMovies('${move.link}&page=$page','')
        .then((value) => {model = value});
        indicator = 0;
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
      snack('No More Pages', '');
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
    UserData().getLan.then((value)async{
      model = HomeTopMovies();
    indicator=1;
    var lnk =
        'https://api.themoviedb.org/3/search/multi?api_key=e11cff04b1fcf50079f6918e5199d691&language=${value['lan']}-${value['country']}&query=$query&page=$page';
    await FirstPageService().getHomeTopMovies(lnk,'').then((value) => {
          model = value,
          if (model.totalPages == 0)
            {count = 0, snack('No Results', '')}
          else if (model.totalPages! < page)
            {snack('No More Results', '')}
        });
      indicator = 0;
    update();
    });
  }

  searchUp(String way, int last) {
    if (way == 'up') {
      if (count != last) {
        count++;
        search(count);
      } else {
        snack('No More Results', '');
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

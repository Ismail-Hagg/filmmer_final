import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:filmmer_final/models/more_search_moving.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import '../models/movie_result_model.dart';
import '../services/home_screen_service.dart';
import '../storage_local/user_data.dart';
import 'connectivity_controller.dart';
import 'home_controller.dart';

class MoreSearchController extends GetxController {
  Move move = Get.find<HomeController>().move;
  HomeTopMovies model = HomeTopMovies();
  int count = 1;
  String query = '';
  int indicator = 0;

  @override
  void onInit() {
    super.onInit();
    firstLoad();
  }

  //load data from api
  getMovies(int page) async {
    if (Get.find<ConnectivityController>().connect.value!=ConnectivityResult.none){
      indicator=1;
    UserData().getLan.then((value)async{
    await FirstPageService()
        .getHomeTopMovies('${move.link}&language=${value['lan']}-${value['country']}&page=$page','')
        .then((value) => {model = value});
        indicator = 0;
    update();
    });
    }else{
      snack('error'.tr, 'internet'.tr);
    }
  }

  //ckeck if your searching 
  firstLoad() {
    if (move.isSearch == false) {
      getMovies(count);
    }
  }

  //next page
  nextPage(int last) async {
    model = HomeTopMovies();
    update();
    if (count == 10) {
      count = 1;
      getMovies(count);
    } else if (count == last) {
      snack('nopage'.tr, '');
    } else {
      count++;
      getMovies(count);
    }
  }

  //previous page
  prePage() async {
    model = HomeTopMovies();
    update();
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
   if (Get.find<ConnectivityController>().connect.value!=ConnectivityResult.none) {
    model = HomeTopMovies();
    indicator=1;
      UserData().getLan.then((value)async{
    var lnk =
        'https://api.themoviedb.org/3/search/multi?api_key=e11cff04b1fcf50079f6918e5199d691&language=${value['lan']}-${value['country']}&query=$query&page=$page';
    await FirstPageService().getHomeTopMovies(lnk,'').then((value) => {
          model = value,
          if (model.totalPages == 0)
            {count = 0, snack('res'.tr, '')}
          else if (model.totalPages! < page)
            {snack('moreres'.tr, '')}
        });
      indicator = 0;
    update();
    });
   } else {
     snack('error'.tr, 'internet'.tr);
   }
  }

  //clip searched pages 
  searchUp(String way, int last) {
    if (way == 'up') {
      if (count != last) {
        count++;
        search(count);
      } else {
        snack('moreres'.tr, '');
      }
    } else {
      if (count == 1 || count == 0) {
      } else {
        count--;
        search(count);
      }
    }
  }
}

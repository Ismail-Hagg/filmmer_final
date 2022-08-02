import 'package:filmmer_final/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../models/movie_detale_model.dart';
import '../models/result_model.dart';
import '../models/trailer_model.dart';
import '../services/home_screen_service.dart';

class MovieDetaleController extends GetxController {
  MovieDetaleModel _detales = MovieDetaleModel();
  MovieDetaleModel get detales => _detales;

  TrailerModel _trailer = TrailerModel();
  TrailerModel get trailer => _trailer;

  @override
  void onInit() {
    super.onInit();
    _detales = Get.find<HomeController>().movied.value;
    loadDetales(_detales);
  }

  loadDetales(MovieDetaleModel res) async {
    var show = res.isShow == true ? 'tv' : 'movie';
    try {
      await FirstPageService()
          .getFromImdb(
        'https://api.themoviedb.org/3/$show/${res.id}?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US',
      )
          .then((value) async {
        _detales = value;
      });
      await FirstPageService()
          .getCast(
              'https://api.themoviedb.org/3/$show/${res.id}/credits?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US')
          .then((value) => {_detales.cast = value});

      await FirstPageService()
          .getRecomended(
              'https://api.themoviedb.org/3/$show/${res.id}/recommendations?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US&page=1')
          .then((value) {
        _detales.recomendation = value;
      });
      await FirstPageService()
          .getTrailer(
              'https://api.themoviedb.org/3/$show/${res.id}/videos?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US')
          .then((value) {
        _trailer = value;
      });
    } catch (e) {
      print(e.toString());
    }
    print('api ready to go');
    update();
  }
}

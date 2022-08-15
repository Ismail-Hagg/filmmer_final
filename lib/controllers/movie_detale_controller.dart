import 'package:filmmer_final/controllers/home_controller.dart';
import 'package:filmmer_final/controllers/watchlist_controller.dart';
import 'package:filmmer_final/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/actor_model.dart';
import '../models/movie_detale_model.dart';
import '../models/trailer_model.dart';
import '../models/upload.dart';
import '../models/user_model.dart';
import '../screens/actor_screen.dart';
import '../screens/trailer_screen.dart';
import '../services/firestore_service.dart';
import '../services/home_screen_service.dart';
import '../storage_local/local_database.dart';
import '../storage_local/user_data.dart';
import 'favourites_controller.dart';

class MovieDetaleController extends GetxController {
  int cuntr = 0;
  final dbHelper = DatabaseHelper.instance;

  MovieDetaleModel _detales = MovieDetaleModel();
  MovieDetaleModel get detales => _detales;

  TrailerModel _trailer = TrailerModel();
  TrailerModel get trailer => _trailer;

  final ActorModel _actor = ActorModel();
  ActorModel get actor => _actor;

  UserModel get usermodel => _usermodel;
  UserModel _usermodel =
      UserModel(email: '', name: '', pic: '', userId: '', isLocal: false);

  var flip = 0.obs;
  var load = 0;

  @override
  void onInit() {
    super.onInit();
    _detales = Get.find<HomeController>().movied.value;
    loadDetales(_detales);
    isFavourite();
  }

  //check if movie or show is in favourites
  isFavourite() async {
    UserData().getUser.then((value) async {
      _usermodel = value;
      await dbHelper
          .querySelect(DatabaseHelper.table, _detales.id.toString())
          .then((value) async {
        if (value.isEmpty) {
          flip.value = 0;
        } else {
          flip.value = 1;
        }
      });
    });
  }

  //add a movie or a show to favourites
  sendObject() async {
    List<String> lst = [];

    for (var i = 0; i < detales.genres!.length; i++) {
      lst.add(detales.genres![i].name.toString());
    }

    FirebaseSend fire = FirebaseSend(
        posterPath: detales.posterPath.toString(),
        overView: detales.overview.toString(),
        voteAverage: detales.voteAverage as double,
        name: detales.title.toString(),
        isShow: detales.isShow as bool,
        releaseDate: detales.releaseDate.toString(),
        id: detales.id.toString(),
        time: DateTime.now().toString(),
        genres: lst);
    if (flip.value == 0) {
      if (Get.isRegistered<FavoritesController>() == true) {
        Get.find<FavoritesController>().fromDetale(fire, true);
      }
      await dbHelper
          .insert(fire.toMapLocal(), DatabaseHelper.table)
          .then((value) async {
        snack('favadd'.tr, '');
        await FireStoreService().upload(_usermodel.userId, fire, flip.value);
        flip.value = 1;
        update();
      });
    } else {
      if (Get.isRegistered<FavoritesController>() == true) {
        Get.find<FavoritesController>().fromDetale(fire, false);
      }
      await dbHelper.delete(DatabaseHelper.table, fire.id).then((value) async {
        snack('favalready'.tr, '');
        await FireStoreService().upload(_usermodel.userId, fire, flip.value);
        flip.value = 0;
        update();
      });
    }
  }

  //add movie or show to watchlist
  watch() async {
    String table = detales.isShow != true
        ? DatabaseHelper.movieTable
        : DatabaseHelper.showTable;
    await dbHelper
        .querySelect(table, detales.id.toString())
        .then((value) async {
      if (value.isEmpty) {
        List<String> lst = [];
        String show = '';
        for (var i = 0; i < detales.genres!.length; i++) {
          lst.add(detales.genres![i].name.toString());
        }
        FirebaseSend fire = FirebaseSend(
            posterPath: detales.posterPath.toString(),
            overView: detales.overview.toString(),
            voteAverage: detales.voteAverage as double,
            name: detales.title.toString(),
            isShow: detales.isShow as bool,
            releaseDate: detales.releaseDate.toString(),
            id: detales.id.toString(),
            time: DateTime.now().toString(),
            genres: lst);
        fire.isShow == true ? show = 'show' : show = 'movie';

        await dbHelper.insert(fire.toMapLocal(), table).then((value) async {
          if (Get.isRegistered<WatchListController>() == true) {
            Get.find<WatchListController>().fromDetale(fire, fire.isShow);
          }
          snack('watchadd'.tr, '');

          await FireStoreService().watchList(_usermodel.userId, fire, show);
        });
      } else {
        snack('watchalready'.tr, '');
      }
    });
  }

  //fetch movie or show detales from api
  loadDetales(MovieDetaleModel res) async {
    UserData().getLan.then((value) async {
      
        load = 0;
    var show = res.isShow == true ? 'tv' : 'movie';
    try {
      await FirstPageService()
          .getFromImdb(
        'https://api.themoviedb.org/3/$show/${res.id}?api_key=e11cff04b1fcf50079f6918e5199d691&language=${value['lan']}-${value['country']}',
      )
          .then((value) async {
        _detales = value;
      });
      await FirstPageService()
          .getCast(
              'https://api.themoviedb.org/3/$show/${res.id}/credits?api_key=e11cff04b1fcf50079f6918e5199d691&language=${value['lan']}-${value['country']}')
          .then((value) => {_detales.cast = value});

      await FirstPageService()
          .getRecomended(
              'https://api.themoviedb.org/3/$show/${res.id}/recommendations?api_key=e11cff04b1fcf50079f6918e5199d691&language=${value['lan']}-${value['country']}')
          .then((value) {
        _detales.recomendation = value;
      });
      await FirstPageService()
          .getTrailer(
              'https://api.themoviedb.org/3/$show/${res.id}/videos?api_key=e11cff04b1fcf50079f6918e5199d691&language=${value['lan']}-${value['country']}')
          .then((value) {
        _trailer = value;
      });
    } catch (e) {
      snack('Error', e.toString());
    }

    load = 1;
    update();
      
    });
  }

  //navigate to actor page
  goToActorPage(String name, String pic) {
    _actor.name = name;
    _actor.pic = pic;
    _actor.age = 0;
    Get.to(() => ActorScreen());
  }

  //navigate to trailer page
  goToTrailer() {
    if (load == 0) {
    } else if (_trailer.results!.isEmpty == true) {
      snack('trailer'.tr, '');
    } else {
      Get.find<HomeController>().trailer.results = _trailer.results;
      Get.to(
        () => const TrailerScreen(),
      );
    }
  }
}

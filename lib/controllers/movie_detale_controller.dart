import 'package:filmmer_final/controllers/home_controller.dart';
import 'package:filmmer_final/helper/constants.dart';
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
import '../storage_local/user_data.dart';

class MovieDetaleController extends GetxController {
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
    UserData().getUser.then((value) {
      _usermodel = value;
      FireStoreService()
          .heart(value.userId, detales.id.toString())
          .then((value) {
        value == true ? flip.value = 1 : flip.value = 0;
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
      await FireStoreService()
          .upload(_usermodel.userId, fire, flip.value)
          .then((value) => {
                Get.snackbar('Added To Favorites', '',
                    duration: const Duration(seconds: 1),
                    backgroundColor: lightColor,
                    colorText: whiteColor),
                flip.value = 1,
                update()
              });
    } else {
      await FireStoreService()
          .upload(_usermodel.userId, fire, flip.value)
          .then((value) => {
                Get.snackbar('Deleted From Favorites', '',
                    duration: const Duration(seconds: 1),
                    backgroundColor: lightColor,
                    colorText: whiteColor),
                flip.value = 0,
                update()
              });
    }
  }

  //add movie or show to watchlist
  watch() async {
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

    await FireStoreService().watchList(_usermodel.userId, fire, show);
  }

  loadDetales(MovieDetaleModel res) async {
    load = 0;
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

    load = 1;
    update();
  }

  goToActorPage(String name, String pic) {
    _actor.name = name;
    _actor.pic = pic;
    _actor.age = 0;
    Get.to(() => ActorScreen());
  }

  goToTrailer(){
    if(load==0){
      print('loading');
    }else{
      Get.find<HomeController>().trailer.results = _trailer.results;
      Get.to(()=>const TrailerScreen(),);
    }
  }
}

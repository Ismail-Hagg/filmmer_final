
import 'package:filmmer_final/helper/constants.dart';
import 'package:filmmer_final/models/actor_model.dart';
import 'package:filmmer_final/storage_local/user_data.dart';
import 'package:get/get.dart';
import '../models/awards_model.dart';
import '../services/home_screen_service.dart';
import 'home_controller.dart';

class ActorController extends GetxController {
  var str = '';
  var it = 0;

  ActorModel _model = ActorModel();
  ActorModel get model => _model;

  int count = 0;

  AwardModel award = AwardModel();
  List<Map<String, String>> awardMapLate = [];
  List<Map<String, String>> awardMap = [];

  @override
  void onInit() {
    _model = Get.find<HomeController>().actor;
    load();
    super.onInit();
  }
  
  //fetch data from api
  load() async {
    getActor();
    getActorMovie();
    getActorShow();
  }

  // switch between showa and movies for the actor
  flip(int number) {
    count = number;
    update();
  }

  // load actor data from api
  getActor() async {
    UserData().getLan.then((value){
      if (value['lan']!= null) {
         FirstPageService()
        .getActor(
            'https://api.themoviedb.org/3/person/${_model.id}?api_key=e11cff04b1fcf50079f6918e5199d691&language=${value['lan']}-${value['country']}')
        .then((value) {
      _model.bio = value.biography;
      _model.age =value.birthday!=null? calculateAge(DateTime.parse(value.birthday.toString()),1):calculateAge(DateTime.parse(value.birthday.toString()),0);
      _model.imdb = value.imdbId;
      getAward(model.imdb.toString(),);
      update();
    });
      } else {
         FirstPageService()
        .getActor(
            'https://api.themoviedb.org/3/person/${_model.id}?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US')
        .then((value) {
      _model.bio = value.biography;
      _model.age =value.birthday!=null? calculateAge(DateTime.parse(value.birthday.toString()),1):calculateAge(DateTime.parse(value.birthday.toString()),0);
      _model.imdb = value.imdbId;
      getAward(model.imdb.toString(),);
      update();
    });
      }
    });
  }

  // load actor data from api
  getActorMovie() async {
    FirstPageService()
        .getActorMovies(
            'https://api.themoviedb.org/3/person/${_model.id}/movie_credits?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US')
        .then((value) {
      _model.movies = value;
      update();
    });
  }

  // load actor data from api
  getActorShow() async {
    FirstPageService()
        .getActorMovies(
            'https://api.themoviedb.org/3/person/${_model.id}/tv_credits?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US')
        .then((value) {
      _model.shows = value;
      update();
    });
  }

  // load actor data from api
  getAward(String id) async {
    await FirstPageService()
        .getAwards(
            'https://imdb-api.com/en/API/NameAwards/k_1dh42prh/$id')
        .then((very) async {
      award = very;
      awardCount(award);
      update();
    });
  }

  //calculate actor's age
  int calculateAge(DateTime birthDate,int flip) {
    if (flip==0) {
      return 0;
    } else {
      DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
    }
  }

  // formatt actor's awards
  awardCount(AwardModel model) {
    awardMapLate = [];
    if (model.items!.isNotEmpty) {
      for (var i = 0; i < model.items!.length; i++) {
      str = '';
      it = 0;

      str = model.items![i].eventTitle.toString();
      for (var x = 0; x < model.items![i].outcomeItems!.length; x++) {
        if (model.items![i].outcomeItems![x].outcomeTitle == 'Winner') {
          it++;
        }
      }

      if (it != 0) {
        awardMapLate.add({'awardName': str, 'count': it.toString()});
      }
    }
    awardMap = awardMapLate;
    } else {
      snack('wrong'.tr,'');
    }
    
  }
}

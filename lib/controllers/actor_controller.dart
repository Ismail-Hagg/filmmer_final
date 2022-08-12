import 'dart:convert';

import 'package:filmmer_final/models/actor_model.dart';
import 'package:get/get.dart';

import '../models/awards_model.dart';
import '../services/home_screen_service.dart';
import 'home_controller.dart';
import 'movie_detale_controller.dart';
import 'package:http/http.dart' as http;

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

  flip(int number) {
    count = number;
    update();
  }

  getActor() async {
    FirstPageService()
        .getActor(
            'https://api.themoviedb.org/3/person/${_model.id}?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US')
        .then((value) {
      _model.bio = value.biography;
      _model.age = calculateAge(DateTime.parse(value.birthday.toString()));
      _model.imdb = value.imdbId;
      getAward(model.imdb.toString(),);
      //test(model.imdb.toString());
      update();
    });
  }

  getActorMovie() async {
    FirstPageService()
        .getActorMovies(
            'https://api.themoviedb.org/3/person/${_model.id}/movie_credits?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US')
        .then((value) {
      _model.movies = value;
      update();
    });
  }

  getActorShow() async {
    FirstPageService()
        .getActorMovies(
            'https://api.themoviedb.org/3/person/${_model.id}/tv_credits?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US')
        .then((value) {
      _model.shows = value;
      update();
    });
  }

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
  int calculateAge(DateTime birthDate) {
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
      print('someting went wrong');
    }
    
  }
}

import 'package:filmmer_final/models/actor_model.dart';
import 'package:get/get.dart';

import '../services/home_screen_service.dart';
import 'home_controller.dart';
import 'movie_detale_controller.dart';

class ActorController extends GetxController{
  ActorModel _model=ActorModel();
  ActorModel get model => _model;

  int count=0;

  @override
  void onInit() {
    _model=Get.find<HomeController>().actor;
    load();
    super.onInit();
    print(_model.name);
  }

  load()async {
    getActor();
    getActorMovie(); 
    getActorShow();
    print('done with the apis');
    
  }

  flip(int number){
    count=number;
    update();
  }

  getActor()async{
    FirstPageService().getActor('https://api.themoviedb.org/3/person/${_model.id}?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US').then((value) {
      _model.bio=value.biography;
      _model.age=calculateAge(DateTime.parse(value.birthday.toString()));
      update();
    });
  }

    getActorMovie()async{
    FirstPageService().getActorMovies('https://api.themoviedb.org/3/person/${_model.id}/movie_credits?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US').then((value) {
      _model.movies=value;
      update();
    });
    }

    getActorShow()async{
    FirstPageService().getActorMovies('https://api.themoviedb.org/3/person/${_model.id}/tv_credits?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US').then((value) {
      _model.shows=value;
      update();
    });
    }

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
}
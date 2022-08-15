//import 'dart:html';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:filmmer_final/models/more_search_moving.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import '../models/actor_model.dart';
import '../models/cast_model.dart';
import '../models/movie_detale_model.dart';
import '../models/movie_result_model.dart';
import '../models/recomended_model.dart';
import '../models/result_model.dart';
import '../models/trailer_model.dart';
import '../models/upload.dart';
import '../screens/actor_screen.dart';
import '../screens/more_search_screen.dart';
import '../screens/movie_detale_screen.dart';
import '../screens/test_screen.dart';
import '../services/home_screen_service.dart';
import '../storage_local/local_database.dart';
import '../storage_local/user_data.dart';
import 'actor_controller.dart';
import 'connectivity_controller.dart';
import 'movie_detale_controller.dart';
import 'dart:io' as io;

class HomeController extends GetxController {
  ActorModel _actor = ActorModel();
  ActorModel get actor => _actor;

  final dbHelper = DatabaseHelper.instance;

  Move move = Move();
  final Rx<HomeTopMovies> _coming = Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get coming => _coming;

  final Rx<HomeTopMovies> _popularMovies =
      Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get popularMovies => _popularMovies;

  final Rx<HomeTopMovies> _popularShows =
      Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get popularShows => _popularShows;

  final Rx<HomeTopMovies> _topRatedMovies =
      Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get topRatedMovies => _topRatedMovies;

  final Rx<HomeTopMovies> _topRatedShows =
      Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get topRatedShows => _topRatedShows;

  final Rx<MovieDetaleModel> _movied = Rx(MovieDetaleModel());
  Rx<MovieDetaleModel> get movied => _movied;

  final TrailerModel _trailer = TrailerModel();
  TrailerModel get trailer => _trailer;

  var count = 0.obs;
  var build = false.obs;
  var track = 0;

  bool picCheck = true;

  Rx<ConnectivityResult> internet = Get.find<ConnectivityController>().connect;
  @override
  void onInit() async {
    build.value = internet.value != ConnectivityResult.none ? true : false;
    super.onInit();
    load();
    existPic();
    ever(internet, (val) => check());
  }

  Future<void> existPic() async {
    await UserData().getUser.then((value) {
      print(value.pic);
      print(value.isLocal);
      File(value.pic).exists().then((value) => chain(value));
    });
  }

  chain(bool val) {
    picCheck = val;
    print(picCheck);
  }

  check() async {
    if (internet.value == ConnectivityResult.none) {
      _coming.value.results!.clear();
    }
    load();
    // if (internet.value != ConnectivityResult.none) {
    //   load();
    //   build.value = true;
    // } else {
    //   build.value = false;
    // }
  }


  //fetch data from api
  load() async {
    count.value = 0;
    if (internet.value != ConnectivityResult.none) {
      UserData().getLan.then((value){
        getUpcoming(upcoming,'${value['lan']}-${value['country']}');
      getpopularMovies(pop,'${value['lan']}-${value['country']}');
      getpopularShows(popularTv,'${value['lan']}-${value['country']}');
      getTopRatedMovies(top,'${value['lan']}-${value['country']}');
      getTopRatedShows(topTv,'${value['lan']}-${value['country']}');
      });
      build.value = true;
      update();
    } else {
      build.value = false;
      update();
    }
    count.value = 1;
  }

  getUpcoming(String link,String lan) async {
    await FirstPageService().getHomeTopMovies(link,lan).then((value) => {
          _coming.value = value,
        });
  }

  getpopularMovies(String link,String lan) async {
    await FirstPageService().getHomeTopMovies(link,lan).then((value) => {
          _popularMovies.value = value,
        });
  }

  getpopularShows(String link,String lan) async {
    await FirstPageService().getHomeTopMovies(link,lan).then((value) => {
          _popularShows.value = value,
        });
  }

  getTopRatedMovies(String link,String lan) async {
    await FirstPageService().getHomeTopMovies(link,lan).then((value) => {
          _topRatedMovies.value = value,
        });
  }

  getTopRatedShows(String link,String lan) async {
    try {
      await FirstPageService().getHomeTopMovies(link,lan).then((value) => {
            _topRatedShows.value = value,
          });
    } catch (e) {
      snack('Error', e.toString());
    }
  }

  //navigate to the detale screen
  navigatoToDetale(Results? res) async {
    if (Get.find<ConnectivityController>().connect.value !=
        ConnectivityResult.none) {
      _movied.value = MovieDetaleModel(
          id: res!.id,
          posterPath: res.posterPath,
          overview: res.overview,
          voteAverage: double.parse(res.voteAverage.toString()),
          title: res.title,
          isShow: res.isShow,
          runtime: 0,
          productionCountries: null,
          genres: null,
          releaseDate: res.releaseDate,
          cast: CastModel(cast: [
            Cast(
                id: 0,
                name: 'Actor',
                profilePath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                character: 'character',
                creditId: 'id'),
            Cast(
                id: 0,
                name: 'Actor',
                profilePath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                character: 'character',
                creditId: 'id'),
            Cast(
                id: 0,
                name: 'Actor',
                profilePath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                character: 'character',
                creditId: 'id'),
            Cast(
                id: 0,
                name: 'Actor',
                profilePath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                character: 'character',
                creditId: 'id'),
            Cast(
                id: 0,
                name: 'Actor',
                profilePath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                character: 'character',
                creditId: 'id')
          ]),
          recomendation: RecomendationModel(results: [
            Results(
                id: 0,
                posterPath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                voteAverage: 0.0.toString()),
            Results(
                id: 0,
                posterPath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                voteAverage: 0.0.toString()),
            Results(
                id: 0,
                posterPath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                voteAverage: 0.0.toString()),
            Results(
                id: 0,
                posterPath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                voteAverage: 0.0.toString()),
            Results(
                id: 0,
                posterPath:
                    'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                voteAverage: 0.0.toString())
          ]));
      // update();
      Get.create(() => (MovieDetaleController()), permanent: false);
      Get.to(() => MovieDetale(tag: res.title.toString()),
          preventDuplicates: false);
    } else {
      snack('Error', 'No Internet connection');
    }
  }

  //navigate to search page
  goToSearch(bool isSearch, String link, String title) {
    if (Get.find<ConnectivityController>().connect.value !=
        ConnectivityResult.none) {
      move = Move(isSearch: isSearch, link: link, title: title);
      Get.to(() => MoreSearchScreen());
    } else {
      snack('Error', 'No Internet connection');
    }
  }

  //navigate to actor page
  goToActor(String? name, String? pic, int? age, String? id, String? bio,
      List<Results>? movies, List<Results>? shows) {
    if (Get.find<ConnectivityController>().connect != ConnectivityResult.none) {
      _actor = ActorModel(
        name: name,
        pic: pic,
        age: age,
        id: id,
        bio: bio,
        movies: movies,
        shows: shows,
      );
      Get.create(() => (ActorController()), permanent: false);
      Get.to(() => ActorScreen(), preventDuplicates: false);
    } else {
      snack('Error', 'No Internet connection');
    }
  }
}

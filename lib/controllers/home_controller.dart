import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../models/movie_model.dart';
import '../services/home_screen_service.dart';

class HomeController extends GetxController {
  final Rx<HomeTopMovies> _coming = Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get coming => _coming;

   final Rx<HomeTopMovies> _popularMovies = Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get popularMovies => _popularMovies;

   final Rx<HomeTopMovies> _popularShows = Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get popularShows => _popularShows;

   final Rx<HomeTopMovies> _topRatedMovies = Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get topRatedMovies => _topRatedMovies;

   final Rx<HomeTopMovies> _topRatedShows = Rx(HomeTopMovies(results: [], initial: [
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg',
    'assets/images/placeholder.jpg'
  ]));
  Rx<HomeTopMovies> get topRatedShows => _topRatedShows;

  var count=0.obs;

  @override
  void onInit() async {
    super.onInit();

    load();

    
  }

  load() async {
    getUpcoming();
    getpopularMovies();
    getpopularShows();
    getTopRatedMovies();
    getTopRatedShows();
    update();
  }

  getUpcoming() async {
    await FirstPageService().getHomeTopMovies(upcoming).then((value) => {
          _coming.value = value,
        });
  }

  getpopularMovies() async {
    await FirstPageService().getHomeTopMovies(pop).then((value) => {
          _popularMovies.value = value,
        });
  }

  getpopularShows() async {
    await FirstPageService().getHomeTopMovies(popularTv).then((value) => {
          _popularShows.value = value,
        });
  }

  getTopRatedMovies() async {
    await FirstPageService().getHomeTopMovies(top).then((value) => {
          _topRatedMovies.value = value,
        });
  }

  getTopRatedShows() async {
    await FirstPageService().getHomeTopMovies(topTv).then((value) => {
          _topRatedShows.value = value,
        });
  }


}



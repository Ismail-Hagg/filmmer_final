import 'package:cached_network_image/cached_network_image.dart';
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
import '../screens/movie_detale_screen.dart';
import '../screens/test_screen.dart';
import '../services/home_screen_service.dart';
import 'movie_detale_controller.dart';

class HomeController extends GetxController {

  ActorModel _actor = ActorModel();
  ActorModel get actor => _actor;
  
  Move move = Move();
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

  final Rx<MovieDetaleModel> _movied = Rx(MovieDetaleModel());
  Rx<MovieDetaleModel> get movied => _movied;

  TrailerModel _trailer=TrailerModel();
  TrailerModel get trailer => _trailer;

  var count=0.obs;

  @override
  void onInit() async {
    super.onInit();
    load();
  }

  //fetch data from api
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
          print(_topRatedMovies.value.results!.length)
        });
  }

  getTopRatedShows() async {
    try {
      await FirstPageService().getHomeTopMovies(topTv).then((value) => {
          _topRatedShows.value = value,
        });
    } catch (e) {
      print(e.toString());
    }
  }

  //navigate to the detale screen
  navigatoToDetale(Results? res) async {
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
          profilePath: 'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
          character: 'character',
          creditId: 'id'
        ),
        Cast(
          id: 0, 
          name: 'Actor',
          profilePath: 'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
          character: 'character',
          creditId: 'id'
        ),
        Cast(
          id: 0, 
          name: 'Actor',
          profilePath: 'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
          character: 'character',
          creditId: 'id'
        ),
        Cast(
          id: 0,
          name: 'Actor',
          profilePath: 'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
          character: 'character',
          creditId: 'id'
        ),
        Cast(
          id: 0,
          name: 'Actor',
          profilePath: 'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
          character: 'character',
          creditId: 'id'
        )
      ]),
      recomendation: RecomendationModel(
        results: [
          Results(
            id: 0,
            posterPath:'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            voteAverage:0.0.toString()
          ),
           Results(
            id: 0,
            posterPath:'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            voteAverage:0.0.toString()
          ),
           Results(
            id: 0,
            posterPath:'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            voteAverage:0.0.toString()
          ),
           Results(
            id: 0,
            posterPath:'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            voteAverage:0.0.toString()
          ),
           Results(
            id: 0,
            posterPath:'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            voteAverage:0.0.toString()
          )
        ]
      )
    );
    // update();
    Get.create(() =>(MovieDetaleController()),permanent: false);
    Get.to(() => MovieDetale(tag:res.title.toString()),preventDuplicates: false);
  }


}

 

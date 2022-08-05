import 'dart:convert';

import 'package:get/get.dart';

import '../models/actor_model.dart';
import '../models/cast_model.dart';
import '../models/movie_detale_model.dart';
import '../models/movie_result_model.dart';
import 'package:http/http.dart' as http;

import '../models/recomended_model.dart';
import '../models/result_model.dart';
import '../models/trailer_model.dart';

class FirstPageService{

  Future<HomeTopMovies> getHomeTopMovies(String api)async{
    dynamic result ='';
    var url = Uri.parse(api);
    try {
      var response = await http.get(url);
      if (response.statusCode==200) {
         result=jsonDecode(response.body);
      }else{
        Get.snackbar('Connection Problem','Status Code Not 200');
      }
      return HomeTopMovies.fromJson(result);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Connection Problem', e.toString());
      return HomeTopMovies();
    }
  }

  Future<MovieDetaleModel> getFromImdb(String api)async{
    dynamic result ='';
    var url = Uri.parse(api);
    try {
      var response = await http.get(url);
      if (response.statusCode==200) {
         result=jsonDecode(response.body);
      }
      return MovieDetaleModel.fromJson(result);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Connection Problem', e.toString());
      return MovieDetaleModel();
    }
  }

  Future<CastModel> getCast(String api)async{
    dynamic result ='';
    var url = Uri.parse(api);
    try {
      var response = await http.get(url);
      if (response.statusCode==200) {
         result=jsonDecode(response.body);
      }
      return CastModel.fromJson(result);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Connection Problem', e.toString());
      return CastModel();
    }
  }

  Future<RecomendationModel> getRecomended(String api)async{
    dynamic result ='';
    var url = Uri.parse(api);
    try {
      var response = await http.get(url);
      if (response.statusCode==200) {
         result=jsonDecode(response.body);
      }
      return RecomendationModel.fromJson(result);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Connection Problem', e.toString());
      return RecomendationModel();
    }
  }

  Future<TrailerModel> getTrailer(String api)async{
    dynamic result ='';
    var url = Uri.parse(api);
    try {
      var response = await http.get(url);
      if (response.statusCode==200) {
         result=jsonDecode(response.body);
      }

      return TrailerModel.fromJson(result);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Connection Problem', e.toString());
      return TrailerModel();
    }
  }

  Future<Actor> getActor(String api)async{
    dynamic result ='';
    var url = Uri.parse(api);
    try {
      var response = await http.get(url);
      if (response.statusCode==200) {
         result=jsonDecode(response.body);
      }

      return Actor.fromJson(result);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Connection Problem', e.toString());
      return Actor();
    }
  }

  Future<List<Results>> getActorMovies(String api)async{
    List<Results> lst=[];
    dynamic result ='';
    var url = Uri.parse(api);
    try {
      var response = await http.get(url);
      if (response.statusCode==200) {
         result=jsonDecode(response.body);
         result['cast'].forEach((v) {
        lst.add(Results.fromJson(v));
      });
      }

      return lst;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Connection Problemsss', e.toString());
      return [];
    }
  }
}
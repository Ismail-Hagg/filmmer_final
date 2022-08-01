import 'dart:convert';

import 'package:get/get.dart';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;

class FirstPageService{

  Future<HomeTopMovies> getHomeTopMovies(String api)async{
    dynamic result ='';
    var url = Uri.parse(api);
    try {
      var response = await http.get(url);
      if (response.statusCode==200) {
         result=jsonDecode(response.body);
      }
      return HomeTopMovies.fromJson(result);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Connection Problem', e.toString());
      return HomeTopMovies();
    }
  }
}
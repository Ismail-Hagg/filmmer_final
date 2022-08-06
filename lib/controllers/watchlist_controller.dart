import 'package:filmmer_final/storage_local/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';
import 'dart:math';
import '../models/result_model.dart';
import '../models/upload.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../widgets/custom_text.dart';
import 'home_controller.dart';

class WatchListController extends GetxController {
  Rx<List<FirebaseSend>> movies = Rx([]);
  Rx<List<FirebaseSend>> shows = Rx([]);

  UserModel get usermodel => _usermodel;
  UserModel _usermodel =
      UserModel(email: '', name: '', pic: '', userId: '', isLocal: false);

  var tabs = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
    ever(movies, (val){print(movies.value.length);});
  }

  getUser(){
    UserData().getUser.then((value) => {
      _usermodel=value,
       movies.bindStream(FireStoreService().getUserMessageStream(
        value.userId, 'movieWatchList')),

    shows.bindStream(FireStoreService().getUserMessageStream(
        value.userId, 'showWatchList')),
    update()

    });
  }

  delete(String id,String collection) async {
    FireStoreService().delete(_usermodel.userId, id,collection);
  }

  void change(int tab) {
    tabs.value = tab;
    update(); 
  }

  navsearched(FirebaseSend send) {
    Get.find<HomeController>().navigatoToDetale(Results(
      id: int.parse(send.id),
      posterPath: send.posterPath,
      overview: send.overView,
      voteAverage: send.voteAverage.toString(),
      title: send.name,
      isShow: send.isShow,
      releaseDate: send.releaseDate,
    ));
  }

  nav() {
    Random random = Random();
    if (tabs == 0) {
      if(movies.value.isNotEmpty){
        int randomNumber = random.nextInt(movies.value.length);
      Get.find<HomeController>().navigatoToDetale(Results(
        id: int.parse(movies.value[randomNumber].id),
        posterPath: movies.value[randomNumber].posterPath,
        overview: movies.value[randomNumber].overView,
        voteAverage: movies.value[randomNumber].voteAverage.toString(),
        title: movies.value[randomNumber].name,
        isShow: movies.value[randomNumber].isShow,
        releaseDate: movies.value[randomNumber].releaseDate,
      ));
      }
    } else {
       if(shows.value.isNotEmpty){
        int randomNumber = random.nextInt(shows.value.length);
      Get.find<HomeController>().navigatoToDetale(Results(
        id: int.parse(shows.value[randomNumber].id),
        posterPath: shows.value[randomNumber].posterPath,
        overview: shows.value[randomNumber].overView,
        voteAverage: shows.value[randomNumber].voteAverage.toString(),
        title: shows.value[randomNumber].name,
        isShow: shows.value[randomNumber].isShow,
        releaseDate: shows.value[randomNumber].releaseDate,
      ));
       }
    }
  }

  search(context) {
    showSearch(
      context: context,
      delegate: SearchPage<FirebaseSend>(
        onQueryUpdate: (s) => print(s),
        items: tabs == 0 ? movies.value : shows.value,
        searchLabel: 'Search people',
        suggestion: const Center(
          child: CustomText(text: 'Search ..', size: 16, color: Colors.white),
        ),
        failure: const Center(
          child:
              CustomText(text: 'No Results  :(', size: 16, color: Colors.white),
        ),
        filter: (person) => [
          person.name,
          // person.surname,
          // person.age.toString(),
        ],
        builder: (person) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: CustomText(
              text: person.name,
              color: Colors.white,
              size: 18,
            ),
            onTap: () {
              //print(items.value.indexOf(person.name));
              navsearched(person);
            },
            // subtitle: Text(person.surname),
            // trailing: Text('${person.age} yo'),
          ),
        ),
      ),
    );
  }
}

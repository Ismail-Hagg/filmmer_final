import 'dart:math';

import 'package:filmmer_final/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';

import '../models/result_model.dart';
import '../models/upload.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../storage_local/user_data.dart';
import '../widgets/custom_text.dart';

class FavoritesController extends GetxController {
  //RxList<FirebaseSend> items=RxList();
  Rx<List<FirebaseSend>> items = Rx([]);

  List<FirebaseSend> filter = [];
  List<String> allGenres = [];
  List<String> selectedGenres = [];
  List<bool> genrebool = [];
  int flip=0;

   UserModel get usermodel => _usermodel;
  UserModel _usermodel =
      UserModel(email: '', name: '', pic: '', userId: '', isLocal: false);

      
  @override
  void onInit() {
    super.onInit();
    getUser();
   
  }

  getUser(){
    UserData().getUser.then((val){
      _usermodel=val;
      items.bindStream(FireStoreService()
        .getUserMessageStream(val.userId,'Favourites'));
    });
  }

  delete(String id,String collection) async {
    FireStoreService().delete(_usermodel.userId, id,collection);
  }

  check(int index) {
    genrebool[index] = !genrebool[index];
    if (selectedGenres.contains(allGenres[index])) {
      selectedGenres.remove(allGenres[index]);
    } else {
      selectedGenres.add(allGenres[index]);
    }
    print(selectedGenres);
    update();
  }

  



  


  randomnav() {
    if (flip==1) {
      if (filter.isEmpty) {
      Get.snackbar('No Evtries', '');
    } else {
      Random random = Random();
      int randomNumber = random.nextInt(filter.length);
      nav(randomNumber);
    }
    } else { 
      if (items.value.isEmpty) {
      Get.snackbar('No Evtries', '');
    } else if (flip==0){
      Random random = Random();
      int randomNumber = random.nextInt(items.value.length);
      nav(randomNumber);
    }    
    }
  }

  nav(int index) {
    Get.find<HomeController>().navigatoToDetale(Results(
      id: int.parse(items.value[index].id),
      posterPath: items.value[index].posterPath,
      overview: items.value[index].overView,
      voteAverage: items.value[index].voteAverage.toString(),
      title: items.value[index].name,
      isShow: items.value[index].isShow,
      releaseDate: items.value[index].releaseDate,
    ));
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

  search(context) {
    showSearch(
      context: context,
      delegate: SearchPage<FirebaseSend>(
        onQueryUpdate: (s) => print(s),
        items: items.value,
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
import 'dart:math';

import 'package:filmmer_final/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';

import '../helper/constants.dart';
import '../models/result_model.dart';
import '../models/upload.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../storage_local/local_database.dart';
import '../storage_local/user_data.dart';
import '../widgets/custom_text.dart';

class FavoritesController extends GetxController {
  List<FirebaseSend> newList = [];
  final dbHelper = DatabaseHelper.instance;


  UserModel get usermodel => _usermodel;
   UserModel _usermodel =
      UserModel(email: '', name: '', pic: '', userId: '', isLocal: false);

  @override
  void onInit() { 
    super.onInit();
    loadDetales();
  }
  //get userdata and favourites from local storage
  loadDetales() async {
    await UserData().getUser.then((value){
      _usermodel=value;
    });
    await dbHelper.queryAllRows(DatabaseHelper.table).then((value) {
      for (var i = 0; i < value.length; i++) {
        newList.add(FirebaseSend.fromMap(value[i]));
      }
      newList.sort((a, b) => b.time.compareTo(a.time));
      update();
    });
  }

  delete(String id, String collection) async {
    FireStoreService().delete(_usermodel.userId, id, collection);
  }

  fromDetale(FirebaseSend send, bool addOrDelete) {
    var str = [];
    if (addOrDelete == true) {
      newList.insert(0,send);
    } else {
      for (var element in newList) {
        str.add(element.id);
      }
      newList.removeAt(str.indexOf(send.id));
    }
    update();
  }

  randomnav() {
    if (newList.isEmpty) {
      snack('No Entries', '');
    } else {
      Random random = Random();
      int randomNumber = random.nextInt(newList.length);
      navv(newList[randomNumber]);
    }
  }

  //delete from local storage and firebase
  void localDelete(String id, int index) async {
    newList.removeAt(index);
    await dbHelper.delete(DatabaseHelper.table, id);
    update();
    delete(id, 'Favourites');
  }

  //navigato to detale page
  navv(FirebaseSend model) {
    Get.find<HomeController>().navigatoToDetale(Results(
      id: int.parse(model.id),
      posterPath: model.posterPath,
      overview: model.overView,
      voteAverage: model.voteAverage.toString(),
      title: model.name,
      isShow: model.isShow,
      releaseDate: model.releaseDate,
    ));
  }


  //search through favourites
  search(context) {
    showSearch(
      context: context,
      delegate: SearchPage<FirebaseSend>(
        items: newList,
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
              navv(person);
            },
          ),
        ),
      ),
    );
  }
}

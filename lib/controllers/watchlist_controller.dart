import 'package:filmmer_final/helper/constants.dart';
import 'package:filmmer_final/storage_local/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';
import 'dart:math';
import '../models/result_model.dart';
import '../models/upload.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../storage_local/local_database.dart';
import '../widgets/custom_text.dart';
import 'home_controller.dart';

class WatchListController extends GetxController {
  final dbHelper = DatabaseHelper.instance;

  List<FirebaseSend> moviesLocal = [];
  List<FirebaseSend> showLocal = [];

  UserModel get usermodel => _usermodel;
  UserModel _usermodel =
      UserModel(email: '', name: '', pic: '', userId: '', isLocal: false);

  var tabs = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  //get user data and watchlist from local storage
  getUser() async {
    await UserData().getUser.then((value) async {
      _usermodel = value;

      await dbHelper.queryAllRows(DatabaseHelper.movieTable).then((value) {
        for (var i = 0; i < value.length; i++) {
          moviesLocal.add(FirebaseSend.fromMap(value[i]));
        }
        moviesLocal.sort((a, b) => b.time.compareTo(a.time));
      });

      await dbHelper.queryAllRows(DatabaseHelper.showTable).then((value) {
        for (var i = 0; i < value.length; i++) {
          showLocal.add(FirebaseSend.fromMap(value[i]));
        }
        showLocal.sort((a, b) => b.time.compareTo(a.time));
      });
    });

    update();
  }

  //delete from local storage and from firebase
  delete(int index, int flip) async {
    String id = '';
    if (flip == 1) {
      id = showLocal[index].id;
      showLocal.removeAt(index);
      await dbHelper.delete(DatabaseHelper.showTable, id);
      update();
      FireStoreService().delete(_usermodel.userId, id, 'showWatchList');
    } else {
      id = moviesLocal[index].id;
      moviesLocal.removeAt(index);
      await dbHelper.delete(DatabaseHelper.movieTable, id);
      update();
      FireStoreService().delete(_usermodel.userId, id, 'movieWatchList');
    }
  }
  
  //move between movies and shows tabs
  void change(int tab) {
    tabs.value = tab;
    update();
  }

  preNav(int index) {
    if (tabs.value == 0) {
      FirebaseSend send = moviesLocal[index];
      navsearched(send);
    } else {
      FirebaseSend send = showLocal[index];
      navsearched(send);
    }
  }

  fromDetale(FirebaseSend send, bool isShow) {
    if (isShow == true) {
      showLocal.insert(0,send);
    } else {
      moviesLocal.insert(0,send);
  }
  update();
  }

  //navigate to detale page
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

  //navigate to a random detale page
  nav() {
    Random random = Random();
    if (tabs.value == 0) {
      if (moviesLocal.isNotEmpty) {
        int randomNumber = random.nextInt(moviesLocal.length);
        Get.find<HomeController>().navigatoToDetale(Results(
          id: int.parse(moviesLocal[randomNumber].id),
          posterPath: moviesLocal[randomNumber].posterPath,
          overview: moviesLocal[randomNumber].overView,
          voteAverage: moviesLocal[randomNumber].voteAverage.toString(),
          title: moviesLocal[randomNumber].name,
          isShow: moviesLocal[randomNumber].isShow,
          releaseDate: moviesLocal[randomNumber].releaseDate,
        ));
      } else {
        snack('No Entries', '');
      }
    } else {
      if (showLocal.isNotEmpty) {
        int randomNumber = random.nextInt(showLocal.length);
        Get.find<HomeController>().navigatoToDetale(Results(
          id: int.parse(showLocal[randomNumber].id),
          posterPath: showLocal[randomNumber].posterPath,
          overview: showLocal[randomNumber].overView,
          voteAverage: showLocal[randomNumber].voteAverage.toString(),
          title: showLocal[randomNumber].name,
          isShow: showLocal[randomNumber].isShow,
          releaseDate: showLocal[randomNumber].releaseDate,
        ));
      } else {
        snack('No Entries', '');
      }
    }
  }

  //search in the watchlist
  search(context) {
    showSearch(
      context: context,
      delegate: SearchPage<FirebaseSend>(
        items: tabs.value == 0 ? moviesLocal : showLocal,
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
              navsearched(person);
            },
          ),
        ),
      ),
    );
  }
}

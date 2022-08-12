import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../models/test_model.dart';
import '../storage_local/local_database.dart';

class ConnectivityController extends GetxController {
  Rx<ConnectivityResult> _connectionStatus = Rx(ConnectivityResult.none);
  ConnectivityResult get connect => _connectionStatus.value;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  List<TestModel> test = [];

  @override
  void onInit() {
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  // addLocal(TestModel model) async {
  //   var db = CartDatabasrHelper.db;
  //   await db.insertUser(model);

  //   update();
  // }

  // getAll() async {
  //   var db = CartDatabasrHelper.db;
  //   test = await db.getAllProducts();
  //   update();
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status ${e.toString()}');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) {
    //   return Future.value(null);
    // }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    update();
  }
}

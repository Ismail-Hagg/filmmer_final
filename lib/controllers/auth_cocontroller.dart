import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filmmer_final/screens/controll_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/constants.dart';
import '../models/upload.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../storage_local/local_database.dart';
import '../storage_local/user_data.dart';

class AuthController extends GetxController {
  final dbHelper = DatabaseHelper.instance;

  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  var count = 0.obs;
  var obscure = true.obs;

  String email = '';
  String password = '';
  String name = '';

  File? _image;
  File? get image => _image;
  dynamic path = '';

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    update();
  }

  //login with google account
  void googleSignInMethod() async {
    count.value = 1;
    try {
      final dynamic googleUser = await _googleSignIn.signIn() ?? '';
      if (googleUser == '') {
        snack('abort'.tr,'');

        count.value = 0;
      } else {
        GoogleSignInAuthentication authy = await googleUser!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: authy.idToken, accessToken: authy.accessToken);
        await _auth.signInWithCredential(credential).then((user) async => {
              saveUser(user, true),
              getDocs(user.user!.uid),
            });
      }
    } on FirebaseAuthException catch (e) {
      snack('Firebase Error', e.toString());

      count.value = 0;
    } catch (e) {
      snack('Error', e.toString());
      count.value = 0;
    }
  }

  //signup with email and Password
  Future<void> register(BuildContext context) async {
    FocusScope.of(context).unfocus();
    count.value = 1;
    if (name == '') {
      snack('error', 'Add Username');
      count.value = 0;
    } else {
      try {
        await auth
            .createUserWithEmailAndPassword(
                email: email.toString(), password: password.toString())
            .then((user) async => {
                  saveUser(user, false),
                  Get.offAll(() => ControllScreen()),
                });
      } on FirebaseAuthException catch (i) {
        snack('error', i.code.toString());

        count.value = 0;
      } catch (e) {
        snack('error', e.toString());
        count.value = 0;
      }
    }
  }

  //login with email and password
  Future<void> login(context) async {
    FocusScope.of(context).unfocus();
    count.value = 1;
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) async => {
                FireStoreService()
                    .getCurrentUser(user.user!.uid)
                    .then((value) async {
                  setUser(
                      UserModel.fromMap(value.data() as Map<dynamic, dynamic>));
                  getDocs(user.user!.uid);
                })
              });
    } on FirebaseAuthException catch (e) {
      snack('Firebase Error', e.code);
      count.value = 0;
    } catch (e) {
      snack('Error', e.toString());
      count.value = 0;
    }
  }

  //signout function
  Future<void> signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    await _auth.signOut();
    await _googleSignIn.signOut();
    await dbHelper.deleteAll(DatabaseHelper.showTable);
    await dbHelper.deleteAll(DatabaseHelper.movieTable);
    await dbHelper.deleteAll(DatabaseHelper.table);
    update();
    Get.offAll(() => ControllScreen());
  }

  support() {
    snack('otherSocial'.tr, '');
  }

  // controlls the switching of obscure text on and off
  obscureChange() {
    obscure.value = !obscure.value;
  }

  // select image from device
  Future<void> openImagePicker() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);

    if (result == null) {
      snack('abort'.tr,'');
    } else {
      path = result.files.single.path;
      _image = File(path.toString());
      update();
    }
  }

  //save user data locally
  void setUser(UserModel user) async {
    await UserData().setUser(user);
    count.value = 0;
    name = '';
    email = '';
    password = '';
    _image = null;
    update();
  }

  // save user data locally and in firestore
  void saveUser(UserCredential user, bool social) async {
    UserModel model = UserModel(
        userId: user.user!.uid,
        email: user.user?.email as String,
        name: social == true ? user.user?.displayName as String : name,
        pic: social == true
            ? user.user?.photoURL as String
            : _image == null
                ? 'assets/images/placeholder.jpg'
                : path.toString(),
        isLocal: !social);

    await FireStoreService().addUsers(model);
    setUser(model);
  }


  //load favourites and watchlist from firestore for user
  Future getDocs(String userId) async {
    List<FirebaseSend> send = [];
    QuerySnapshot fav = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection('Favourites')
        .get();
    QuerySnapshot mov = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection('movieWatchList')
        .get();
    QuerySnapshot sho = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection('showWatchList')
        .get();
    if (fav.docs.isNotEmpty) {
      send = [];
      for (int i = 0; i < fav.docs.length; i++) {
        var a = fav.docs[i].data();
        send.add(FirebaseSend.fromMapPre(a as Map<String, dynamic>));
        await dbHelper.insert(send[i].toMapLocal(), DatabaseHelper.table);
      }
    }

    if (mov.docs.isNotEmpty) {
      send = [];
      for (int i = 0; i < mov.docs.length; i++) {
        var a = mov.docs[i].data();
        send.add(FirebaseSend.fromMapPre(a as Map<String, dynamic>));
        await dbHelper.insert(send[i].toMapLocal(), DatabaseHelper.movieTable);
      }
    }

    if (sho.docs.isNotEmpty) {
      send = [];
      for (int i = 0; i < sho.docs.length; i++) {
        var a = sho.docs[i].data();
        send.add(FirebaseSend.fromMapPre(a as Map<String, dynamic>));
        await dbHelper.insert(send[i].toMapLocal(), DatabaseHelper.showTable);
      }
    }
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:filmmer_final/screens/controll_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helper/constants.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../storage_local/user_data.dart';

class AuthController extends GetxController {
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
        Get.snackbar('Aborted','',
          backgroundColor: lightColor);
        count.value = 0;
      } else {
        GoogleSignInAuthentication authy = await googleUser!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: authy.idToken, accessToken: authy.accessToken);
        await _auth.signInWithCredential(credential).then((user) async => {
              saveUser(user,true),
            });
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('fuck Firebase: ${e.code}', e.toString(),
          backgroundColor: lightColor);
      count.value = 0;
    } catch (e) {
      Get.snackbar('fuck: ', e.toString(),
          backgroundColor: lightColor, colorText: Colors.white);
      count.value = 0;
    }
  }

  //signup with email and Password
  Future<void> register(BuildContext context) async {
    FocusScope.of(context).unfocus();
    count.value = 1;
    if (name == '') {
      Get.snackbar('error', 'Add Username',
          snackPosition: SnackPosition.BOTTOM);
      count.value = 0;
    } else {
      try {
        await auth
            .createUserWithEmailAndPassword(
                email: email.toString(), password: password.toString())
            .then((user) async => {
                  saveUser(user,false),
                  Get.offAll(() => ControllScreen()),
                });
      } on FirebaseAuthException catch (i) {
        Get.snackbar('error', i.code.toString(),
            snackPosition: SnackPosition.BOTTOM);
        count.value = 0;
      } catch (e) {
        Get.snackbar('error', e.toString(),
            snackPosition: SnackPosition.BOTTOM);
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
                FireStoreService().getCurrentUser(user.user!.uid).then((value) async{
                  setUser(UserModel.fromMap(value.data() as Map<dynamic, dynamic>));
                })
              });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      count.value = 0;
    } catch (e) {
      Get.snackbar('error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      count.value = 0;
    }
  } 

  //signout function
  Future<void> signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
    UserData().deleteUser;
    update();
    Get.offAll(() => ControllScreen());
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
      print('nothing man');
    } else {
      path = result.files.single.path;
      _image = File(path.toString());
      
      print('path is here $path');
      update();
    }
  }
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
    void saveUser(UserCredential user,bool social) async {
    UserModel model = UserModel(
      userId: user.user!.uid,
      email: user.user?.email as String,
      name: social==true? user.user?.displayName as String : name,
      pic: social==true?
          user.user?.photoURL as String
          : _image == null
              ? 'assets/images/placeholder.jpg'
              : path.toString(),
      isLocal: !social
         
    );

    await FireStoreService().addUsers(model);
     setUser(model);
  }
}

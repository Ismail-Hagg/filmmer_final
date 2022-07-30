import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helper/constants.dart';

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

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }


  //login with google account
  void googleSignInMethod() async {
    count.value = 1;
    try {
      //count.value = 1;
      final dynamic googleUser = await _googleSignIn.signIn() ?? '';
      if (googleUser == '') {
        print('failed');
        count.value = 0;
      } else {
        GoogleSignInAuthentication authy = await googleUser!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: authy.idToken, accessToken: authy.accessToken);
        await _auth.signInWithCredential(credential).then((user) async => {
          count.value = 0,
                email = '',
                password = '',
                name = '',
                update()
              // saveUser(user),
              
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

  //login with email and password
  Future<void> login(context) async {
    FocusScope.of(context).unfocus();
    count.value = 1;
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) async => {
                count.value = 0,
                email = '',
                password = '',
                name = '',
                update()
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
    update();
  }

  // controlls the switching of obscure text on and off
  obscureChange() {
    obscure.value = !obscure.value;
  }
}

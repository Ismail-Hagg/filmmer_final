import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../helper/constants.dart';
import '../models/user_model.dart';

class UserData{
   Future<UserModel> get getUser async{
    try {
      UserModel model = await  _getUserData();
      return model;
    }catch(e){
      print('error : ${e.toString()}');
      return UserModel(email: 'error', name: 'error', pic: '', userId: '', isLocal: false);  
    }
  }
 
  setUser(UserModel model)async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(CASHED_USER_DATE, json.encode(model.toMap()));
  }

  Future<UserModel> _getUserData()async{ 
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getString(CASHED_USER_DATE);

    return UserModel.fromMap(json.decode(value.toString()));
    
  } 
 
  void deleteUser()async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    print('we out side');
   
  }
}
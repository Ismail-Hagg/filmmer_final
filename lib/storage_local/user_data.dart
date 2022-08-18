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

  Future<Map<String,String>> get getLan async{
    try {
      Map<String,String> map = await  _getLan();
      return map;
    }catch(e){
      return {};  
    }
  }
 
  setUser(UserModel model)async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(CASHED_USER_DATE, json.encode(model.toMap()));
  }

  setLan(String lan,String country)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('lan', lan);
    await pref.setString('country', country);
  }

  Future<UserModel> _getUserData()async{ 
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getString(CASHED_USER_DATE);

    return UserModel.fromMap(json.decode(value.toString()));
    
  } 
  Future<Map<String,String>> _getLan()async{ 
    Map<String,String> map ={};
    SharedPreferences pref = await SharedPreferences.getInstance();
    var languange = pref.getString('lan');
    var country = pref.getString('country');

    map={
      'lan':languange.toString(),
      'country':country.toString(),
    };

    return map;
    
  } 
 
  Future<void> deleteUser()async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
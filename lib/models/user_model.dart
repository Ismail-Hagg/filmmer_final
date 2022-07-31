import 'dart:convert';

class UserModel {
  final String userId;
  final String email;
  final String name;
  bool isLocal;
  String pic;
  
  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.pic,
    required this.isLocal,
  });

  toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
      'isLocal': isLocal,
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      email: map['email'],
      name: map['name'],
      pic: map['pic'],
      isLocal: map['isLocal'],
    );
  }

  String toJson(UserModel model) => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

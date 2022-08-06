import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSend {

  String posterPath;
  String overView;
  double voteAverage;
  String name;
  bool isShow;
  String releaseDate;
  String id;
  String time;
  List<dynamic> genres;
  FirebaseSend({
    required this.posterPath,
    required this.overView,
    required this.voteAverage,
    required this.name,
    required this.isShow,
    required this.releaseDate,
    required this.id,
    required this.time,
    required this.genres,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'posterPath': posterPath,
      'overView': overView,
      'voteAverage': voteAverage,
      'name': name,
      'isShow': isShow,
      'releaseDate': releaseDate,
      'id': id,
      'time':time,
      'genres': genres,
    };
  }

  factory FirebaseSend.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return FirebaseSend(
      posterPath: documentSnapshot['posterPath'] as String,
      overView: documentSnapshot['overView'] as String,
      voteAverage: documentSnapshot['voteAverage'] as double,
      name: documentSnapshot['name'] as String,
      isShow: documentSnapshot['isShow'] as bool,
      releaseDate: documentSnapshot['releaseDate'] as String,
      id: documentSnapshot['id'] as String,
      time: documentSnapshot['time'] ,
      genres: documentSnapshot['genres'],
    );
  }
  

  

}


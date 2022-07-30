import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final Future<FirebaseApp> firebaseInit = Firebase.initializeApp();

const primaryColor =  Color.fromRGBO(48, 48, 48, 1);
const lightColor = Color.fromRGBO(238, 141, 51, 1);
const mainColor = Color.fromRGBO(55, 56, 62, 1);

const CASHED_USER_DATE='Save';
const imagebase = 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2';

const upcoming='https://api.themoviedb.org/3/movie/upcoming?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US';
const pop='https://api.themoviedb.org/3/movie/popular?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US';
const popularTv='https://api.themoviedb.org/3/tv/popular?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US';
const top='https://api.themoviedb.org/3/movie/top_rated?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US';
const topTv='https://api.themoviedb.org/3/tv/top_rated?api_key=e11cff04b1fcf50079f6918e5199d691&language=en-US';
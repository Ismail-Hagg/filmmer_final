import 'package:filmmer_final/models/result_model.dart';

class ActorModel{
  String? id;
  String? name;
  String? pic;
  String? bio;
  int? age;
  List<Results>? movies;
  List<Results>? shows;
  List<Awards>? awards;
  String? imdb;

  ActorModel({this.id,this.name, this.pic, this.bio, this.age, this.movies, this.shows, this.awards,this.imdb});

}

class Awards{
  String? awardName;
  int? count;
  Awards({this.awardName, this.count});
}

class Actor {
  String? biography;
  String? birthday;
  int? id;
  String? imdbId;
  String? name;
  String? profilePath;

  Actor(
      {
      this.biography,
      this.birthday,
      this.id,
      this.imdbId,
      this.name,
      this.profilePath});

  Actor.fromJson(Map<String, dynamic> json) {
    biography = json['biography'];
    birthday = json['birthday'];
    id = json['id'];
    imdbId = json['imdb_id'];
    name = json['name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['biography'] = biography;
    data['birthday'] = birthday;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['name'] = name;
    data['profile_path'] = profilePath;
    return data;
  }
}
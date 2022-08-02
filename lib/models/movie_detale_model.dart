import 'cast_model.dart';
import 'genres_model.dart';
import 'languages_model.dart';
import 'prod_country_model.dart';
import 'recomended_model.dart';

class MovieDetaleModel {
  bool? adult;
  List<Genres>? genres;
  int? id;
  String? imdbId;
  String? overview;
  String? posterPath;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  int? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  double? voteAverage;
  bool? isShow;
  CastModel? cast;
  RecomendationModel? recomendation;

  MovieDetaleModel(
      {this.adult,
      this.genres,
      this.id,
      this.imdbId,
      this.overview,
      this.posterPath,
      this.productionCountries,
      this.releaseDate,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.voteAverage,
      this.isShow,
      this.cast,
      this.recomendation});

  MovieDetaleModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add( Genres.fromJson(v));
      });
    }
    id = json['id'];
    imdbId = json['imdb_id'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      json['production_companies'].forEach((v) {});
    }
    if (json['production_countries'] != null) {
      productionCountries = <ProductionCountries>[];
      json['production_countries'].forEach((v) {
        productionCountries!.add( ProductionCountries.fromJson(v));
      });
    }
    releaseDate = json['release_date'] ?? json['first_air_date'];
    runtime = json['runtime'] == null
        ? json['seasons'][0]['season_number'] == 0
            ? json['seasons'].length - 1
            : json['seasons'].length
        : json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguages>[];
      json['spoken_languages'].forEach((v) {
        spokenLanguages!.add( SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'] ?? json['name'];
    voteAverage = json['vote_average'] ?? 0.0;
    isShow = json['first_air_date'] == null ? false : true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['adult'] = adult;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    if (productionCountries != null) {
      data['production_countries'] =
        productionCountries!.map((v) => v.toJson()).toList();
    }
    data['release_date'] = releaseDate;
    data['runtime'] = runtime;
    if (spokenLanguages != null) {
      data['spoken_languages'] =
          spokenLanguages!.map((v) => v.toJson()).toList();
    }
    data['status'] =status;
    data['tagline'] =tagline;
    data['title'] = title;
    data['vote_average'] = voteAverage;

    return data;
  }
}
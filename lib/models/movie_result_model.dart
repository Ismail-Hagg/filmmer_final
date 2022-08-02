import 'package:filmmer_final/models/result_model.dart';

class HomeTopMovies {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;
  List<String>? initial;

  HomeTopMovies({this.page, this.results, this.totalPages, this.totalResults,this.initial});

  HomeTopMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add( Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    initial=[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] =totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/tv_model.dart';

class GenreMovieModel {
  final int id;
  final String name;
  List<Movie>? movies;
  GenreMovieModel({required this.id, required this.name, this.movies});

  factory GenreMovieModel.fromJson(Map<String, dynamic> json) {
    return GenreMovieModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}



class GenreTvModel {
  final int id;
  final String name;
  List<TvModel>? movies;
  GenreTvModel({required this.id, required this.name, this.movies});

  factory GenreTvModel.fromJson(Map<String, dynamic> json) {
    return GenreTvModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

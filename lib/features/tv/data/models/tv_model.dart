// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flixstar/api/api.dart';
import 'package:flixstar/core/utils/constants.dart';

class TvModel {
  bool? adult;
  String? source;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;

  TvModel({
    this.adult,
    this.source,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
  });

  TvModel.fromJson(Map<String, dynamic> json) {
    API api = API();
    adult = json['adult'];
    backdropPath = api.tmdb.images.getUrl(json['backdrop_path']) ??
        Constants.backdroPlaceholder;
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = api.tmdb.images.getUrl(json['poster_path']) ??
        Constants.backdroPlaceholder;
    firstAirDate = json['first_air_date'];
    name = json['name'];
  }
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['source'] = source;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['first_air_date'] = firstAirDate;
    data['name'] = name;
    return data;
  }

  TvModel copyWith({
    bool? adult,
    String? source,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    String? firstAirDate,
    String? name,
    double? voteAverage,
    int? voteCount,
  }) {
    return TvModel(
      adult: adult ?? this.adult,
      source: source ?? this.source,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originCountry: originCountry ?? this.originCountry,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      name: name ?? this.name,
    );
  }
}

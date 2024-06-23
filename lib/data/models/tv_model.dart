import 'package:dooflix/api/api.dart';
import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/core/utils/constants.dart';

class TvModel {
  bool? adult;

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
  double? voteAverage;
  int? voteCount;

  TvModel(
      {this.adult,
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
      this.voteAverage,
      this.voteCount});

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
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  TvModel.fromTvDetails(TvDetails tvDetails) {
    adult = tvDetails.adult;
    backdropPath = tvDetails.backdropPath;
    genreIds = tvDetails.genres!.map((e) => e.id!).toList();
    id = tvDetails.id;
    originCountry = tvDetails.originCountry;
    originalLanguage = tvDetails.originalLanguage;
    originalName = tvDetails.originalName;
    overview = tvDetails.overview;
    popularity = tvDetails.popularity;
    posterPath = tvDetails.posterPath;
    firstAirDate = tvDetails.firstAirDate;
    name = tvDetails.name;
    voteAverage = tvDetails.voteAverage;
    voteCount = tvDetails.voteCount;
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
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['first_air_date'] = firstAirDate;
    data['name'] = name;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

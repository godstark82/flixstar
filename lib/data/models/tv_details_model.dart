import 'package:dooflix/api/api.dart';
import 'package:dooflix/data/models/source_model.dart';
import 'package:dooflix/data/models/tv_model.dart';

class TvDetails {
  bool? adult;
  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<Genres>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  List<Networks>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Seasons>? seasons;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  TvDetails(
      {this.adult,
      this.backdropPath,
      this.createdBy,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.homepage,
      this.id,
      this.inProduction,
      this.languages,
      this.lastAirDate,
      this.lastEpisodeToAir,
      this.name,
      this.networks,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.seasons,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.type,
      this.voteAverage,
      this.voteCount});

  TvDetails.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = API().tmdb.images.getUrl(json['backdrop_path']);
    if (json['created_by'] != null) {
      createdBy = <CreatedBy>[];
      json['created_by'].forEach((v) {
        createdBy!.add(CreatedBy.fromJson(v));
      });
    }
    episodeRunTime = json['episode_run_time'].cast<int>();
    firstAirDate = json['first_air_date'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    inProduction = json['in_production'];
    languages = json['languages'].cast<String>();
    lastAirDate = json['last_air_date'];
    lastEpisodeToAir = json['last_episode_to_air'] != null
        ? LastEpisodeToAir.fromJson(json['last_episode_to_air'])
        : null;
    name = json['name'];
    if (json['networks'] != null) {
      networks = <Networks>[];
      json['networks'].forEach((v) {
        networks!.add(Networks.fromJson(v));
      });
    }
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = API().tmdb.images.getUrl(json['poster_path']);

    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(Seasons.fromJson(v));
      });
    }
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguages>[];
      json['spoken_languages'].forEach((v) {
        spokenLanguages!.add(SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    if (createdBy != null) {
      data['created_by'] = createdBy!.map((v) => v.toJson()).toList();
    }
    data['episode_run_time'] = episodeRunTime;
    data['first_air_date'] = firstAirDate;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['in_production'] = inProduction;
    data['languages'] = languages;
    data['last_air_date'] = lastAirDate;
    if (lastEpisodeToAir != null) {
      data['last_episode_to_air'] = lastEpisodeToAir!.toJson();
    }
    data['name'] = name;
    if (networks != null) {
      data['networks'] = networks!.map((v) => v.toJson()).toList();
    }
    data['number_of_episodes'] = numberOfEpisodes;
    data['number_of_seasons'] = numberOfSeasons;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;

    if (seasons != null) {
      data['seasons'] = seasons!.map((v) => v.toJson()).toList();
    }
    if (spokenLanguages != null) {
      data['spoken_languages'] =
          spokenLanguages!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['type'] = type;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class CreatedBy {
  int? id;
  String? creditId;
  String? name;
  String? originalName;
  int? gender;
  String? profilePath;

  CreatedBy(
      {this.id,
      this.creditId,
      this.name,
      this.originalName,
      this.gender,
      this.profilePath});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creditId = json['credit_id'];
    name = json['name'];
    originalName = json['original_name'];
    gender = json['gender'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['credit_id'] = creditId;
    data['name'] = name;
    data['original_name'] = originalName;
    data['gender'] = gender;
    data['profile_path'] = profilePath;
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class LastEpisodeToAir {
  int? id;
  String? overview;
  String? name;
  double? voteAverage;
  double? voteCount;
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  LastEpisodeToAir(
      {this.id,
      this.overview,
      this.name,
      this.voteAverage,
      this.voteCount,
      this.airDate,
      this.episodeNumber,
      this.episodeType,
      this.productionCode,
      this.runtime,
      this.seasonNumber,
      this.showId,
      this.stillPath});

  LastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    overview = json['overview'];
    name = json['name'];
    voteAverage = json['vote_average'];
    voteCount = double.parse(json['vote_count'].toString());
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    episodeType = json['episode_type'];
    productionCode = json['production_code'];
    runtime = json['runtime'];
    seasonNumber = json['season_number'];
    showId = json['show_id'];
    stillPath = json['still_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['overview'] = overview;
    data['name'] = name;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['episode_type'] = episodeType;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['still_path'] = stillPath;
    return data;
  }
}

class Networks {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Networks({this.id, this.logoPath, this.name, this.originCountry});

  Networks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    return data;
  }
}

class Seasons {
  String? airDate;
  int? episodeCount;
  int? id;
  List<TvEpisode>? episodes;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  Seasons(
      {this.airDate,
      this.episodeCount,
      this.episodes,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber,
      this.voteAverage});

  Seasons.fromJson(Map<String, dynamic> json) {
    episodes = [];
    airDate = json['air_date'];
    episodeCount = json['episode_count'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    posterPath = API().tmdb.images.getUrl(json['poster_path']);
    seasonNumber = json['season_number'];
    voteAverage = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_count'] = episodeCount;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    data['vote_average'] = voteAverage;
    return data;
  }
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    return data;
  }
}

class TvEpisode {
  MediaSource? playingSource;
  String? airDate;
  int? episodeNumber;
  String? name;
  String? overview;
  int? id;
  int? runtime;
  int? seasonNumber;
  String? stillPath;

  TvEpisode(
      {this.airDate,
      this.episodeNumber,
      this.playingSource,
      this.name,
      this.overview,
      this.id,
      this.runtime,
      this.seasonNumber,
      this.stillPath});

  TvEpisode.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    name = json['name'];
    overview = json['overview'];
    id = json['id'];
    runtime = json['runtime'];
    seasonNumber = json['season_number'];
    stillPath = API().tmdb.images.getUrl(json['still_path'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['playing_source'] = playingSource?.toJson();
    data['episode_number'] = episodeNumber;
    data['name'] = name;
    data['overview'] = overview;
    data['id'] = id;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['still_path'] = stillPath;
    return data;
  }
}

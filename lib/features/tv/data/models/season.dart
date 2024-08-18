class TvSeason {
  TvSeason({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });
  late final String _id;
  late final String airDate;
  late final List<Episodes> episodes;
  late final String name;
  late final String overview;
  late final int id;
  late final String posterPath;
  late final int seasonNumber;
  late final int voteAverage;
  
  TvSeason.fromJson(Map<String, dynamic> json){
    _id = json['_id'];
    airDate = json['air_date'];
    episodes = List.from(json['episodes']).map((e)=>Episodes.fromJson(e)).toList();
    name = json['name'];
    overview = json['overview'];
    id = json['id'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
    voteAverage = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['air_date'] = airDate;
    _data['episodes'] = episodes.map((e)=>e.toJson()).toList();
    _data['name'] = name;
    _data['overview'] = overview;
    _data['id'] = id;
    _data['poster_path'] = posterPath;
    _data['season_number'] = seasonNumber;
    _data['vote_average'] = voteAverage;
    return _data;
  }
}

class Episodes {
  Episodes({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.crew,
    required this.guestStars,
  });
  late final String airDate;
  late final int episodeNumber;
  late final String episodeType;
  late final int id;
  late final String name;
  late final String overview;
  late final String productionCode;
  late final int runtime;
  late final int seasonNumber;
  late final int showId;
  late final String stillPath;
  late final double voteAverage;
  late final int voteCount;
  late final List<Crew> crew;
  late final List<GuestStars> guestStars;
  
  Episodes.fromJson(Map<String, dynamic> json){
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    episodeType = json['episode_type'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    runtime = json['runtime'];
    seasonNumber = json['season_number'];
    showId = json['show_id'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    crew = List.from(json['crew']).map((e)=>Crew.fromJson(e)).toList();
    guestStars = List.from(json['guest_stars']).map((e)=>GuestStars.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['air_date'] = airDate;
    _data['episode_number'] = episodeNumber;
    _data['episode_type'] = episodeType;
    _data['id'] = id;
    _data['name'] = name;
    _data['overview'] = overview;
    _data['production_code'] = productionCode;
    _data['runtime'] = runtime;
    _data['season_number'] = seasonNumber;
    _data['show_id'] = showId;
    _data['still_path'] = stillPath;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    _data['crew'] = crew.map((e)=>e.toJson()).toList();
    _data['guest_stars'] = guestStars.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Crew {
  Crew({
    required this.job,
    required this.department,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
     this.profilePath,
  });
  late final String job;
  late final String department;
  late final String creditId;
  late final bool adult;
  late final int gender;
  late final int id;
  late final String knownForDepartment;
  late final String name;
  late final String originalName;
  late final double popularity;
  late final String? profilePath;
  
  Crew.fromJson(Map<String, dynamic> json){
    job = json['job'];
    department = json['department'];
    creditId = json['credit_id'];
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['job'] = job;
    _data['department'] = department;
    _data['credit_id'] = creditId;
    _data['adult'] = adult;
    _data['gender'] = gender;
    _data['id'] = id;
    _data['known_for_department'] = knownForDepartment;
    _data['name'] = name;
    _data['original_name'] = originalName;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    return _data;
  }
}

class GuestStars {
  GuestStars({
    required this.character,
    required this.creditId,
    required this.order,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });
  late final String character;
  late final String creditId;
  late final int order;
  late final bool adult;
  late final int gender;
  late final int id;
  late final String knownForDepartment;
  late final String name;
  late final String originalName;
  late final double popularity;
  late final String profilePath;
  
  GuestStars.fromJson(Map<String, dynamic> json){
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['character'] = character;
    _data['credit_id'] = creditId;
    _data['order'] = order;
    _data['adult'] = adult;
    _data['gender'] = gender;
    _data['id'] = id;
    _data['known_for_department'] = knownForDepartment;
    _data['name'] = name;
    _data['original_name'] = originalName;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    return _data;
  }
}
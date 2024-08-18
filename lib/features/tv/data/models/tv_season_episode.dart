class TvEpisode {
  TvEpisode({
    required this.airDate,
    required this.crew,
    required this.episodeNumber,
    required this.guestStars,
    required this.name,
    required this.overview,
    required this.id,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });
  late final String airDate;
  late final List<Crew> crew;
  late final int episodeNumber;
  late final List<GuestStars> guestStars;
  late final String name;
  late final String overview;
  late final int id;
  late final String productionCode;
  late final int runtime;
  late final int seasonNumber;
  late final String stillPath;
  late final double voteAverage;
  late final int voteCount;
  
  TvEpisode.fromJson(Map<String, dynamic> json){
    airDate = json['air_date'];
    crew = List.from(json['crew']).map((e)=>Crew.fromJson(e)).toList();
    episodeNumber = json['episode_number'];
    guestStars = List.from(json['guest_stars']).map((e)=>GuestStars.fromJson(e)).toList();
    name = json['name'];
    overview = json['overview'];
    id = json['id'];
    productionCode = json['production_code'];
    runtime = json['runtime'];
    seasonNumber = json['season_number'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['air_date'] = airDate;
    _data['crew'] = crew.map((e)=>e.toJson()).toList();
    _data['episode_number'] = episodeNumber;
    _data['guest_stars'] = guestStars.map((e)=>e.toJson()).toList();
    _data['name'] = name;
    _data['overview'] = overview;
    _data['id'] = id;
    _data['production_code'] = productionCode;
    _data['runtime'] = runtime;
    _data['season_number'] = seasonNumber;
    _data['still_path'] = stillPath;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
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
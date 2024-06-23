// ignore_for_file: prefer_collection_literals

class AnimeDetailsModel {
  String? id;
  String? title;
  String? url;
  List<String>? genres;
  int? totalEpisodes;
  String? image;
  String? releaseDate;
  String? description;
  String? subOrDub;
  String? type;
  String? status;
  String? otherName;
  List<Episodes>? episodes;

  AnimeDetailsModel(
      {this.id,
      this.title,
      this.url,
      this.genres,
      this.totalEpisodes,
      this.image,
      this.releaseDate,
      this.description,
      this.subOrDub,
      this.type,
      this.status,
      this.otherName,
      this.episodes});

  AnimeDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    genres = json['genres'].cast<String>();
    totalEpisodes = json['totalEpisodes'];
    image = json['image'];
    releaseDate = json['releaseDate'];
    description = json['description'];
    subOrDub = json['subOrDub'];
    type = json['type'];
    status = json['status'];
    otherName = json['otherName'];
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['genres'] = genres;
    data['totalEpisodes'] = totalEpisodes;
    data['image'] = image;
    data['releaseDate'] = releaseDate;
    data['description'] = description;
    data['subOrDub'] = subOrDub;
    data['type'] = type;
    data['status'] = status;
    data['otherName'] = otherName;
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodes {
  String? id;
  int? number;
  String? url;

  Episodes({this.id, this.number, this.url});

  Episodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['number'] = number;
    data['url'] = url;
    return data;
  }
}

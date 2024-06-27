import 'package:dooflix/features/anime/domain/entities/anime_genre_entity.dart';
import 'package:jikan_api/jikan_api.dart';

// ignore: must_be_immutable
class AnimeGenreModel extends AnimeGenreEntity {
   AnimeGenreModel({
    required super.title,
    required super.id,
    required super.animes,
  });

  factory AnimeGenreModel.fromJson(Map<String, dynamic> json) {
    return AnimeGenreModel(
      title: json['name'],
      id: json['mal_id'],
      animes: (json['animes'] as BuiltList)
          .map((e) => Anime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'mal_id': id,
      'animes': animes?.map((item) => item.toJson())
    };
  }
}

import 'package:equatable/equatable.dart';
import 'package:jikan_api/jikan_api.dart';

// ignore: must_be_immutable
abstract class AnimeGenreEntity extends Equatable {
  String? title;
  int? id;
  List<Anime>? animes;

  AnimeGenreEntity({this.title, this.id, this.animes});
  @override
  List<Object?> get props => [title, id, animes];
}

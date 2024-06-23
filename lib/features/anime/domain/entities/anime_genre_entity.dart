import 'package:equatable/equatable.dart';
import 'package:jikan_api/jikan_api.dart';

abstract class AnimeGenreEntity extends Equatable {
  final String title;
  final int id;
  final List<Anime> animes;

  const AnimeGenreEntity(
      {required this.title, required this.id, required this.animes});
  @override
  List<Object?> get props => [title, id, animes];
}

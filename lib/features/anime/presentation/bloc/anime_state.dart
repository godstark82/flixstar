part of 'anime_bloc.dart';

abstract class AnimeHomeState extends Equatable {
  final BuiltList<Anime>? topAnime;
  final BuiltList<Genre>? genres;
  final List<AnimeGenreModel>? genreAnime;
  final BuiltList<Anime>? popularAnime;

  const AnimeHomeState(
      {this.topAnime, this.genres, this.genreAnime, this.popularAnime});

  @override
  List<Object> get props => [];
}

class AnimeInitial extends AnimeHomeState {}

class AnimeLoading extends AnimeHomeState {
  const AnimeLoading() : super();
}

class AnimeLoaded extends AnimeHomeState {
  const AnimeLoaded(
      {super.topAnime, super.genres, super.genreAnime, super.popularAnime});
}

class AnimeError extends AnimeHomeState {
  final String message;
  const AnimeError(this.message);
}

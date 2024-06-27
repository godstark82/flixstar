part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  //* Movies Data
  final List<Movie>? popularMovie;
  final List<Movie>? trendingMovie;
  final List<GenreMovieModel>? movieGenres;

  //? TV DATA
  final List<TvModel>? topRatedTvs;
  final List<GenreTvModel>? tvGenres;

  //! ANIME DATA
  final BuiltList<Anime>? topAnime;
  final List<AnimeGenreModel>? animeGenreData;

  const HomeState(
      {this.movieGenres,
      this.animeGenreData,
      this.topAnime,
      this.popularMovie,
      this.trendingMovie,
      this.tvGenres,
      this.topRatedTvs});

  @override
  List<Object?> get props => [popularMovie, trendingMovie, movieGenres];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState() : super();
}

class HomeLoadedState extends HomeState {
  const HomeLoadedState({
    required super.popularMovie,
    required super.trendingMovie,
    required super.movieGenres,
    required super.tvGenres,
    required super.topRatedTvs,
    required super.topAnime,
    required super.animeGenreData,
  });
}

class HomeAnimeLoadingState extends HomeState {
  const HomeAnimeLoadingState(
      {super.movieGenres,
      super.popularMovie,
      super.topRatedTvs,
      super.trendingMovie,
      super.tvGenres})
      : super();
}

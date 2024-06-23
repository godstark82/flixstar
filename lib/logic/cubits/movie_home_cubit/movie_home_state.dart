part of 'movie_home_cubit.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieLoadingState extends MovieState {}

final class MovieLoadedState extends MovieState {
  final List<Movie> trendingMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> popularMovies;
  final List<GenreMovieModel> genres;
  final List<GenreTvModel> tvGenres;
  const MovieLoadedState({
    required this.trendingMovies,
    required this.tvGenres,
    required this.topRatedMovies,
    required this.popularMovies,
    required this.genres,
  });
}

final class MovieErrorState extends MovieState {
  final String errorMsg;
  const MovieErrorState(this.errorMsg);
}

import 'package:bloc/bloc.dart';
import 'package:dooflix/data/models/genre_model.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/repositories/movie_repo.dart';
import 'package:dooflix/data/repositories/tv_repo.dart';
import 'package:equatable/equatable.dart';

part 'movie_home_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieLoadingState()) {
    fetchMovie();
  }

  MovieRepository movieRepository = MovieRepository();
  void fetchMovie() async {
    try {
      List<Movie> trendingMovies = await movieRepository.fetchTrendingMovies();
      List<Movie> topRatedMovies = await movieRepository.fetchTopRatedMovies();
      List<Movie> popularMovies = await movieRepository.fetchPopularMovies();
      

      List<GenreMovieModel> genres = await movieRepository.getGenres();
      List<GenreTvModel> tvGenres = await TvRepository().getGenres();

      emit(MovieLoadedState(
        trendingMovies: trendingMovies,
        topRatedMovies: topRatedMovies,
        popularMovies: popularMovies,
        tvGenres: tvGenres,
        genres: genres,
      ));
    } catch (e) {
      emit(MovieErrorState(e.toString()));
      rethrow;
    }
  }
}

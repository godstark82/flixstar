import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/features/movie/data/models/genre_movie_model.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<DataState<List<Movie>>> getTrendingMovies();

  Future<DataState<List<Movie>>> getTopRatedMovies();

  Future<DataState<List<Movie>>> getPopularMovies();

  Future<DataState<Movie>> getMovieDetail({required Movie movie});

  Future<DataState<List<Movie>>> getRelatedMovies({required int id});

  Future<DataState<List<GenreMovieModel>>> getAllGenreData();

  Future<DataState<List<Movie>>> getGenres(
      {required int id, int page = 1});
}

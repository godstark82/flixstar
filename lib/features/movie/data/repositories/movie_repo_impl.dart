import 'package:dio/dio.dart';
import 'package:flixstar/api/api.dart';
import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/features/movie/data/models/genre_movie_model.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  API api = API();
  MovieRepositoryImpl(this.api);
  @override
  Future<DataState<List<GenreMovieModel>>> getAllGenreData() async {
    try {
      final response = await api.tmdb.v3.genres.getMovieList();
      List<Map<String, dynamic>> genres = (response['genres'] as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      List<GenreMovieModel> genreModels =
          genres.map((e) => GenreMovieModel.fromJson(e)).toList();

      // Create a list of futures
      final futures = genreModels.map((genreModel) async {
        final genreResponse = await getGenres(id: genreModel.id);
        genreModel.movies = genreResponse.data;
      }).toList();

      // Wait for all futures to complete
      await Future.wait(futures);

      return DataSuccess(genreModels);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<List<Movie>>> getGenres(
      {required int id, int page = 1}) async {
    try {
      final movieResponse = await api.tmdb.v3.discover.getMovies(
          withGenres: id.toString(),
          page: page,
          watchRegion: 'IN',
          withOrginalLanguage: 'hi');
      List<Map<String, dynamic>> results = (movieResponse['results'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      List<Movie> movies = results.map((e) => Movie.fromJson(e)).toList();
      return DataSuccess(movies);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<Movie>> getMovieDetail({required Movie movie}) async {
    try {
      final String html = api.getMovieSource(movie.id!);
      return DataSuccess(movie.copyWith(source: html));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<List<Movie>>> getPopularMovies() async {
    try {
      final response = await api.tmdb.v3.movies.getPopular();
      final List<dynamic> results = response['results'];
      final List<Movie> popularMovies = results
          .map((dynamic item) => Movie.fromJson(item as Map<String, dynamic>))
          .toList();
      return DataSuccess(popularMovies);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<List<Movie>>> getRelatedMovies({required int id}) async {
    try {
      Map response = await api.tmdb.v3.movies.getSimilar(id);
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<Movie> relatedMovies =
          results.map((map) => Movie.fromJson(map)).toList();

      return DataSuccess(relatedMovies);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<List<Movie>>> getTopRatedMovies() async {
    try {
      Map response = await api.tmdb.v3.movies.getTopRated();
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<Movie> topRatedMovies =
          results.map((map) => Movie.fromJson(map)).toList();
      return DataSuccess(topRatedMovies);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<List<Movie>>> getTrendingMovies() async {
    try {
      Map response = await api.tmdb.v3.trending.getTrending();
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<Movie> tredingMovies =
          results.map((map) => Movie.fromJson(map)).toList();
      return DataSuccess(tredingMovies);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }
}

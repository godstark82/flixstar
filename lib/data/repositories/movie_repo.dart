import 'dart:developer';
import 'package:dooflix/api/api.dart';
import 'package:dooflix/data/models/genre_model.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:hive_flutter/adapters.dart';

class MovieRepository {
  API api = API();

  Future<List<Movie>> getHistory() async {
    try {
      List<Movie> movies = [];
      List<Map<String, dynamic>>? mappedHistory =
          (await Hive.box('library').get('history-movies') as List)
              .map((v) => Map<String, dynamic>.from(v))
              .toList();

      if (mappedHistory != []) {
        movies = mappedHistory.map((movie) => Movie.fromJson(movie)).toList();
        return movies;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToHistory(Movie movie) async {
    try {
      List<Map<String, dynamic>> mappedHistory =
          (await Hive.box('library').get('history-movies') as List)
              .map((v) => Map<String, dynamic>.from(v))
              .toList();
      mappedHistory.add(movie.toJson());
      await Hive.box('library').put('history-movies', mappedHistory);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> fetchTrendingMovies() async {
    try {
      Map response = await api.tmdb.v3.trending.getTrending();
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<Movie> tredingMovies =
          results.map((map) => Movie.fromJson(map)).toList();
      return tredingMovies;
    } catch (ex) {
      log(ex.toString(), error: ex);
      rethrow;
    }
  }

  /// fetch topRatedMovies
  Future<List<Movie>> fetchTopRatedMovies() async {
    try {
      Map response = await api.tmdb.v3.movies.getTopRated();
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<Movie> topRatedMovies =
          results.map((map) => Movie.fromJson(map)).toList();
      return topRatedMovies;
    } catch (ex) {
      rethrow;
    }
  }

  /// fetch topRatedMovies
  Future<List<Movie>> fetchPopularMovies() async {
    try {
      Map response = await api.tmdb.v3.movies.getPopular();
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<Movie> popularMovies =
          results.map((map) => Movie.fromJson(map)).toList();
      return popularMovies;
    } catch (ex) {
      rethrow;
    }
  }

  /// fetch upcomingMovies
  Future<List<Movie>> fetchUpcomingMovies() async {
    try {
      Map response = await api.tmdb.v3.movies.getUpcoming();
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<Movie> upcomingMovies =
          results.map((map) => Movie.fromJson(map)).toList();
      return upcomingMovies;
    } catch (ex) {
      rethrow;
    }
  }

  /// Search a Specific Movie with TMDB id
  Future<Movie> fetchMovieById(int id) async {
    try {
      final otherIdMap = await api.tmdb.v3.movies.getExternalIds(id);
      final imdbID = otherIdMap['imdb_id'];
      Map response = await api.tmdb.v3.find.getById(imdbID);
      List<Map<String, dynamic>> movieResults =
          (response['movie_results'] as List)
              .map((map) => Map<String, dynamic>.from(map))
              .toList();
      return Movie.fromJson(movieResults.first).copyWith(id: imdbID);
    } catch (ex) {
      rethrow;
    }
  }

  /// fetch Related Movies by TMDB ID
  Future<List<Movie>> fetchRelatedMovie(int id) async {
    try {
      Map response = await api.tmdb.v3.movies.getSimilar(id);
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<Movie> relatedMovies =
          results.map((map) => Movie.fromJson(map)).toList();

      return relatedMovies;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<GenreMovieModel>> getGenres() async {
    final response = await api.tmdb.v3.genres.getMovieList();
    List<Map<String, dynamic>> genres = (response['genres'] as List<dynamic>)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    List<GenreMovieModel> genreModels =
        genres.map((e) => GenreMovieModel.fromJson(e)).toList();

    for (var i = 0; i < genreModels.length; i++) {
      genreModels[i].movies = await getGenreMovies(genreModels[i].id);
    }
    return genreModels;
  }

  Future<List<Movie>> getGenreMovies(int id, {int page = 1}) async {
    final movieResponse = await api.tmdb.v3.discover.getMovies(
        withGenres: id.toString(),
        page: page,
        watchRegion: 'IN',
        withOrginalLanguage: 'hi');
    List<Map<String, dynamic>> results = (movieResponse['results'] as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    List<Movie> movies = results.map((e) => Movie.fromJson(e)).toList();
    return movies;
  }

  //? Networks
  Future<List<Movie>> getNetworkMovies(String name, {int page = 1}) async {
    // final response = await api.tmdb.v3.networks.

    final response = await api.tmdb.v3.discover.getMovies(
      withWatchProviders: name,
      region: 'IN',
      // watchRegion: 'IN',
      page: page,
      withOrginalLanguage: 'hi',
    );
    final results = (response['results'] as List)
        .map((result) => Map<String, dynamic>.from(result))
        .toList();
    List<Movie> movies = results.map((map) => Movie.fromJson(map)).toList();
    return movies;
  }
  // end of repo
}

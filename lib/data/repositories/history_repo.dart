import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:hive_flutter/adapters.dart';

class HistoryRepo {
  final box = Hive.box('library');

  Future<void> deleteMovie(Movie movie) async {
    List<Map<String, dynamic>> mappedHistory =
        (await box.get('history-movies') as List)
            .map((v) => Map<String, dynamic>.from(v))
            .toList();
    mappedHistory.removeWhere((element) => element['id'] == movie.id);
    await box.put('history-movies', mappedHistory);
  }

  Future<void> deleteTv(TvModel tv) async {
    List<Map<String, dynamic>> mappedHistory =
        (await box.get('history-tvs') as List)
            .map((v) => Map<String, dynamic>.from(v))
            .toList();
    mappedHistory.removeWhere((element) => element['id'] == tv.id);
    await box.put('history-tvs', mappedHistory);
  }

  Future<void> addMovieToHistory(Movie movie) async {
    try {
      List<Map<String, dynamic>> mappedHistory =
          (await Hive.box('library').get('history-movies') != null)
              ? (await Hive.box('library').get('history-movies') as List)
                  .map((v) => Map<String, dynamic>.from(v))
                  .toList()
              : [];
      mappedHistory.add(movie.toJson());
      await Hive.box('library').put('history-movies', mappedHistory);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TvModel>> getTvHistory() async {
    try {
      List<TvModel> tvs = [];
      List<Map<String, dynamic>>? mappedHistory =
          ((await Hive.box('library').get('history-tvs') as List?) ?? [])
              .map((v) => Map<String, dynamic>.from(v))
              .toList();

      if (mappedHistory != []) {
        tvs = mappedHistory.map((movie) => TvModel.fromJson(movie)).toList();
        return tvs;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTvToHistory(TvModel tv) async {
    try {
      List<Map<String, dynamic>> mappedHistory =
          ((await Hive.box('library').get('history-tvs') as List?) ?? [])
              .map((v) => Map<String, dynamic>.from(v))
              .toList();
      mappedHistory.add(tv.toJson());
      await Hive.box('library').put('history-tvs', mappedHistory);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> getMovieHistory() async {
    try {
      List<Movie> movies = [];
      List<Map<String, dynamic>>? mappedHistory =
          ((await Hive.box('library').get('history-movies') as List?) ?? [])
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
}

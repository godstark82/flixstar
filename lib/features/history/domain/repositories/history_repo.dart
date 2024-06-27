import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';

abstract class HistoryRepository {
  // DELETE
  Future<void> deleteMovie(Movie movie);

  Future<void> deleteTv(TvModel tv);

  // ADD
  Future<void> addMovieToHistory(Movie movie);

  Future<void> addTvToHistory(TvModel tv);

  // GET
  Future<List<Movie>> getMovieHistory();

  Future<List<TvModel>> getTvHistory();
}

import 'package:flixstar/api/api.dart';
import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/search/domain/repositories/search_repo.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/injection_container.dart';

class SeachRepoImpl implements SearchRepo {
  final api = sl<API>();

  @override
  Future<DataState<List<Movie>>> searchMovie(String query) async {
    try {
      final response = await api.tmdb.v3.search.queryMovies(query);
      var result = (response['results'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      List<Movie> movies = result.map((e) => Movie.fromJson(e)).toList();

      return DataSuccess(movies);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataState<List<TvModel>>> searchTv(String query) async {
    try {
      final response = await api.tmdb.v3.search.queryTvShows(query);
      var result = (response['results'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      List<TvModel> movies = result.map((e) => TvModel.fromJson(e)).toList();

      return DataSuccess(movies);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:dooflix/api/api.dart';
import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/search/domain/repositories/search_repo.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';

class SeachRepoImpl implements SearchRepo {
  API api = API();

  @override
  Future<DataState<List<Movie>>> searchMovie(String query) async {
    try {
      final response = await api.tmdb.v3.search.queryMovies(query);
      var result = (response['results'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      List<Movie> movies = result.map((e) => Movie.fromJson(e)).toList();
      // print(result.runtimeType);
      // for (var i = 0; i < movies.length; i++) {
      // PlayerApi playerApi = PlayerApi();
      // movies[i].playSource = await playerApi.videoUrl(movies[i].id!);
      // }
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
      // print(result.runtimeType);

      return DataSuccess(movies);
    } catch (e) {
      rethrow;
    }
  }
}

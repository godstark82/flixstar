import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';

abstract class SearchRepo {
  Future<DataState<List<Movie>>> searchMovie(String query);
  Future<DataState<List<TvModel>>> searchTv(String query);
  // Future<DataState<List<Anime>>> searchAnime(String query);
}

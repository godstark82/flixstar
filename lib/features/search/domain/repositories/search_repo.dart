import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';

abstract class SearchRepo {
  Future<DataState<List<Movie>>> searchMovie(String query);
  Future<DataState<List<TvModel>>> searchTv(String query);
  // Future<DataState<List<Anime>>> searchAnime(String query);
}

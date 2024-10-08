import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/features/tv/data/models/genre_tv_model.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';

abstract class TvRepository {
  Future<DataState<List<TvModel>>> getPopular();

  Future<DataState<List<TvModel>>> getTopRated();

  Future<DataState<TvModel>> getTvDetails(int id);

  Future<DataState<List<TvModel>>> getRelatedTvs(TvModel tv);

  Future<DataState<List<GenreTvModel>>> getAllGenresData();

  Future<DataState<List<TvModel>>> getTvsOfGenre(int id, {int page = 1});
}

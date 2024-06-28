import 'package:dio/dio.dart';
import 'package:dooflix/api/api.dart';
import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/features/tv/data/models/genre_tv_model.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';
import 'package:dooflix/features/tv/domain/repositories/tv_repository.dart';

class TvRepoImpl implements TvRepository {
  final API api = API();
  @override
  Future<DataState<List<TvModel>>> getPopular() async {
    try {
      Map response = await api.tmdb.v3.tv.getPopular(
        language: 'EN',
      );
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<TvModel> popularMovies =
          results.map((map) => TvModel.fromJson(map)).toList();
      return DataSuccess(popularMovies);
    } catch (ex) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<List<GenreTvModel>>> getAllGenresData() async {
    try {
      final response = await api.tmdb.v3.genres.getTvlist(language: 'in-HI');
      final List<dynamic> genres = response['genres'];
      final List<GenreTvModel> genreModels = genres
          .map((dynamic e) => GenreTvModel.fromJson(e as Map<String, dynamic>))
          .toList();

      final futures = genreModels.map((genreModel) async {
        final tvResponse = await getTvsOfGenre(genreModel.id);
        genreModel.movies = tvResponse.data;
      }).toList();

      await Future.wait(futures);

      return DataSuccess(genreModels);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<List<TvModel>>> getRelatedTvs(TvModel tv) async {
    try {
      Map response = await api.tmdb.v3.tv.getSimilar(tv.id!, language: 'in-HI');
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<TvModel> relatedMovies =
          results.map((map) => TvModel.fromJson(map)).toList();

      return DataSuccess(relatedMovies);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<List<TvModel>>> getTopRated() async {
    try {
      Map response = await api.tmdb.v3.tv.getTopRated(language: 'HI');
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<TvModel> tredingMovies =
          results.map((map) => TvModel.fromJson(map)).toList();
      return DataSuccess(tredingMovies);
    } catch (ex) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: ex)));
    }
  }

  @override
  Future<DataState<TvModel>> getTvDetails(TvModel tv) async {
    try {
      final newTv = tv.copyWith(source: await api.getTvSource(tv.id!));
      return DataSuccess(newTv);
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(data: e)));
    }
  }

  @override
  Future<DataState<List<TvModel>>> getTvsOfGenre(int id, {int page = 1}) async {
    try {
      final movieResponse = await api.tmdb.v3.discover.getTvShows(
          withGenres: id.toString(),
          page: page,
          watchRegion: 'IN',
          withOrginalLanguage: 'hi');
      List<Map<String, dynamic>> results = (movieResponse['results'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      List<TvModel> movies = results.map((e) => TvModel.fromJson(e)).toList();
      return DataSuccess(movies);
    } catch (e) {
      //
      rethrow;
    }
  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/features/anime/domain/repositories/anime_repository.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeRepoImpl implements AnimeRepository {
  final Jikan jikan;

  AnimeRepoImpl(this.jikan);

  @override
  Future<DataState<BuiltList<Anime>>> getTopAnime({required int page}) async {
    try {
      return DataSuccess(await jikan.getTopAnime());
    } catch (e) {
      log(e.toString());
      return DataFailed(DioException(
          requestOptions: RequestOptions(
        data: e,
      )));
    }
  }

  @override
  Future<DataState<BuiltList<Genre>>> getAnimeGenres(
      {required GenreType type}) async {
    try {
      return DataSuccess(await jikan.getAnimeGenres(type: type));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<Anime>> getAnimeDetail({required int id}) async {
    try {
      return DataSuccess(await jikan.getAnime(id));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<BuiltList<Anime>>> searchAnime(
      {required String query}) async {
    try {
      return DataSuccess(await jikan.searchAnime(query: query));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<BuiltList<Recommendation>>> getAnimeRecommendations(
      {required int id}) async {
    try {
      return DataSuccess(await jikan.getAnimeRecommendations(id));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<BuiltList<Anime>>> getAnimeByGenre(
      {required int id, required int page}) async {
    try {
      return DataSuccess(await jikan.searchAnime(
        genres: [id],
        page: page,
      ));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<BuiltList<Anime>>> getAnimeByPopularity(
      {required int page}) async {
    try {
      return DataSuccess(await jikan.getTopAnime());
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<BuiltList<Anime>>> getAnimeByFavorites(
      {required int page}) async {
    try {
      return DataSuccess(await jikan.getTopAnime());
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<BuiltList<Anime>>> getAnimeByYear(
      {required int year, required int page}) async {
    try {
      return DataSuccess(await jikan.searchAnime(
        sort: 'year',
      ));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<BuiltList<Anime>>> getAnimeBySeason(
      {required SeasonType season,
      required int year,
      required int page}) async {
    try {
      return DataSuccess(
          await jikan.getSeason(season: season, year: year, page: page));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<BuiltList<Anime>>> getAnimeByType(
      {required AnimeType type, required int page}) async {
    try {
      return DataSuccess(await jikan.searchAnime(type: type));
    } catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions()));
    }
  }
}

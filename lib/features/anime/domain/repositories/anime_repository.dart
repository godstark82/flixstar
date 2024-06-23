import 'package:dooflix/core/resources/data_state.dart';
import 'package:jikan_api/jikan_api.dart';

abstract class AnimeRepository {
  Future<DataState<BuiltList<Anime>>> getTopAnime({required int page});

  Future<DataState<BuiltList<Genre>>> getAnimeGenres({required GenreType type});

  Future<DataState<Anime>> getAnimeDetail({required int id});

  Future<DataState<BuiltList<Anime>>> searchAnime({required String query});

  Future<DataState<BuiltList<Recommendation>>> getAnimeRecommendations(
      {required int id});

  Future<DataState<BuiltList<Anime>>> getAnimeByGenre(
      {required int id, required int page});

  Future<DataState<BuiltList<Anime>>> getAnimeByPopularity({required int page});

  Future<DataState<BuiltList<Anime>>> getAnimeByFavorites({required int page});

  Future<DataState<BuiltList<Anime>>> getAnimeByYear(
      {required int year, required int page});

  Future<DataState<BuiltList<Anime>>> getAnimeBySeason(
      {required SeasonType season, required int year, required int page});

  Future<DataState<BuiltList<Anime>>> getAnimeByType(
      {required AnimeType type, required int page});
}

import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/features/anime/data/models/anime_genre_model.dart';
import 'package:jikan_api/jikan_api.dart';

abstract class AnimeRepository {
  Future<DataState<BuiltList<Anime>>> getTopAnime({required int page});

  Future<DataState<Anime>> getAnimeDetail({required int id});

  Future<DataState<BuiltList<Anime>>> searchAnime({required String query});

  Future<DataState<BuiltList<Recommendation>>> getAnimeRecommendations(
      {required int id});

  Future<DataState<BuiltList<Genre>>> getGenres({required GenreType type});

  Future<DataState<BuiltList<Anime>>> getAnimeByGenre(
      {required int id, required int page});

  Future<DataState<List<AnimeGenreModel>>> getAllGenresData();
}

import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/anime/domain/repositories/anime_repository.dart';
import 'package:jikan_api/jikan_api.dart';

class GenreAnimesUsecase implements UserCase<DataState<BuiltList<Anime>>, Map> {
  final AnimeRepository animeRepository;

  GenreAnimesUsecase(this.animeRepository);

  @override
  Future<DataState<BuiltList<Anime>>> call(
    Map params,
  ) async {
    return await animeRepository.getAnimeByGenre(
        id: params['id'], page: params['page']);
  }
}

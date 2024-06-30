import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/anime/domain/repositories/anime_repository.dart';
import 'package:flixstar/injection_container.dart';
import 'package:jikan_api/jikan_api.dart';

class TopAnimeUseCase implements UseCase<DataState<BuiltList<Anime>>, int> {
  TopAnimeUseCase();

  @override
  Future<DataState<BuiltList<Anime>>> call(int page) async {
    final animeRepository = sl<AnimeRepository>();
    return await animeRepository.getTopAnime(page: page);
  }
}

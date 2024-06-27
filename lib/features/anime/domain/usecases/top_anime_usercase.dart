import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/anime/data/repositories/anime_repo_impl.dart';
import 'package:dooflix/injection_container.dart';
import 'package:jikan_api/jikan_api.dart';

class TopAnimeUseCase implements UseCase<DataState<BuiltList<Anime>>, int> {
  TopAnimeUseCase();

  @override
  Future<DataState<BuiltList<Anime>>> call(int page) async {
    final animeRepository = sl<AnimeRepoImpl>();
    return await animeRepository.getTopAnime(page: page);
  }
}

import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/anime/domain/repositories/anime_repository.dart';
import 'package:jikan_api/jikan_api.dart';

class PopularAnimeUseCase
    implements UserCase<DataState<BuiltList<Anime>>, int> {
  final AnimeRepository animeRepository;

  PopularAnimeUseCase(this.animeRepository);

  @override
  Future<DataState<BuiltList<Anime>>> call(int page) async {
    return await animeRepository.getAnimeByPopularity(page: page);
  }
}

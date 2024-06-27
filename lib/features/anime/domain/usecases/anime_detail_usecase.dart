import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/anime/data/repositories/anime_repo_impl.dart';
import 'package:dooflix/injection_container.dart';
import 'package:jikan_api/jikan_api.dart';

class GetAnimeDetailUseCase implements UseCase<DataState<Anime>, int> {
  GetAnimeDetailUseCase();

  @override
  Future<DataState<Anime>> call(int id) async {
    final animeRepository = sl<AnimeRepoImpl>();
    return await animeRepository.getAnimeDetail(id: id);
  }
}

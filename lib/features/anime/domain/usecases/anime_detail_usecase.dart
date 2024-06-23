import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/anime/domain/repositories/anime_repository.dart';
import 'package:jikan_api/jikan_api.dart';

class GetAnimeDetailUseCase implements UserCase<DataState<Anime>, int> {
  final AnimeRepository animeRepository;
  GetAnimeDetailUseCase(this.animeRepository);

  @override
  Future<DataState<Anime>> call(int id) async {
    return await animeRepository.getAnimeDetail(id: id);
  }
}

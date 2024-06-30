import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/anime/domain/repositories/anime_repository.dart';
import 'package:flixstar/injection_container.dart';
import 'package:jikan_api/jikan_api.dart';

class GetAnimeDetailUseCase implements UseCase<DataState<Anime>, int> {
  GetAnimeDetailUseCase();

  @override
  Future<DataState<Anime>> call(int id) async {
    final animeRepository = sl<AnimeRepository>();
    return await animeRepository.getAnimeDetail(id: id);
  }
}

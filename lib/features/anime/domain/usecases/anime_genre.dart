import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/anime/domain/repositories/anime_repository.dart';
import 'package:jikan_api/jikan_api.dart';

class GenresOfAnimeUseCase
    implements UserCase<DataState<BuiltList<Genre>>, GenreType> {
  final AnimeRepository animeRepository;
  GenresOfAnimeUseCase(this.animeRepository);

  @override
  Future<DataState<BuiltList<Genre>>> call(GenreType type) async {
    return await animeRepository.getAnimeGenres(type: type);
  }
}

import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/anime/data/models/anime_genre_model.dart';
import 'package:dooflix/features/anime/data/repositories/anime_repo_impl.dart';

class GetAnimeGenresDataUseCase
    extends UseCase<DataState<List<AnimeGenreModel>>, void> {
  AnimeRepoImpl animeRepository;

  GetAnimeGenresDataUseCase(this.animeRepository);
  @override
  Future<DataState<List<AnimeGenreModel>>> call(void params) async {
    return await animeRepository.getAllGenresData();
  }
}

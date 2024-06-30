import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/anime/data/models/anime_genre_model.dart';
import 'package:flixstar/features/anime/domain/repositories/anime_repository.dart';
import 'package:flixstar/injection_container.dart';

class GetAnimeGenresDataUseCase
    extends UseCase<DataState<List<AnimeGenreModel>>, void> {
  GetAnimeGenresDataUseCase();
  @override
  Future<DataState<List<AnimeGenreModel>>> call(void params) async {
    final animeRepo = sl<AnimeRepository>();
    return await animeRepo.getAllGenresData();
  }
}

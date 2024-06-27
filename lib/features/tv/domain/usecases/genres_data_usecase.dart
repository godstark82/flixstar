import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/tv/data/models/genre_tv_model.dart';
import 'package:dooflix/features/tv/data/repositories/tv_repo_impl.dart';
import 'package:dooflix/injection_container.dart';

class GetAllTvGenresUseCase
    extends UseCase<DataState<List<GenreTvModel>>, void> {
  GetAllTvGenresUseCase();

  @override
  Future<DataState<List<GenreTvModel>>> call(void params) async {
    final tvRepository = sl<TvRepoImpl>();
    return await tvRepository.getAllGenresData();
  }
}



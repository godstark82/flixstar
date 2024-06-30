import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/tv/data/models/genre_tv_model.dart';
import 'package:flixstar/features/tv/domain/repositories/tv_repository.dart';
import 'package:flixstar/injection_container.dart';

class GetAllTvGenresUseCase
    extends UseCase<DataState<List<GenreTvModel>>, void> {
  GetAllTvGenresUseCase();

  @override
  Future<DataState<List<GenreTvModel>>> call(void params) async {
    final tvRepository = sl<TvRepository>();
    return await tvRepository.getAllGenresData();
  }
}



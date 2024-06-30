import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/domain/repositories/tv_repository.dart';
import 'package:flixstar/injection_container.dart';

class GetPopularUseCase extends UseCase<DataState<List<TvModel>>, void> {
  GetPopularUseCase();
  @override
  Future<DataState<List<TvModel>>> call(void params) async {
    final tvRepository = sl<TvRepository>();
    return await tvRepository.getPopular();
  }
}

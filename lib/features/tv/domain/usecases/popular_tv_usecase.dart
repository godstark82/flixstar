import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';
import 'package:dooflix/features/tv/data/repositories/tv_repo_impl.dart';
import 'package:dooflix/injection_container.dart';

class GetPopularUseCase extends UseCase<DataState<List<TvModel>>, void> {
  GetPopularUseCase();
  @override
  Future<DataState<List<TvModel>>> call(void params) async {
    final tvRepository = sl<TvRepoImpl>();
    return await tvRepository.getPopular();
  }
}

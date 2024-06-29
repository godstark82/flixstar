import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/data/repositories/tv_repo_impl.dart';
import 'package:flixstar/injection_container.dart';

class GetTvDetailsUseCase extends UseCase<DataState<TvModel>, TvModel> {
  GetTvDetailsUseCase();

  @override
  Future<DataState<TvModel>> call(TvModel params) async {
    final tvRepository = sl<TvRepoImpl>();
    return await tvRepository.getTvDetails(params);
  }
}

import 'package:dooflix/data/repositories/tv_repo.dart';
import 'package:dooflix/logic/cubits/tv_home_cubit/tv_home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvHomeCubit extends Cubit<TvHomeState> {
  TvHomeCubit() : super(LoadingHomeTvState()) {
    fetchHomeTv();
  }

  Future<void> fetchHomeTv() async {
    emit(LoadingHomeTvState());
    try {
      TvRepository repo = TvRepository();


      final topRatedTvs = await repo.fetchTopRatedTvs();
      final genres = await repo.getGenres();

      emit(LoadedHomeTvState(
          genres: genres,   topRatedTvs: topRatedTvs));
    } catch (ex) {
      emit(ErrorHomeTvState());
    }
  }
}

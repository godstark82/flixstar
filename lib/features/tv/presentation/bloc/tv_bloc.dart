import 'package:bloc/bloc.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/domain/usecases/related_tv_usecase.dart';
import 'package:flixstar/features/tv/domain/usecases/tv_detail_usecase.dart';
import 'package:equatable/equatable.dart';
part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetailsUseCase getTvDetailsUseCase;
  final GetRelatedTvUseCase getRelatedUseCase;

  TvBloc(this.getTvDetailsUseCase, this.getRelatedUseCase)
      : super(TvLoadingState()) {
    on<LoadTvEvent>(_onLoadTvDetail);
  }

  void _onLoadTvDetail(LoadTvEvent event, Emitter<TvState> emit) async {
    emit(TvLoadingState());

    try {
      final relatedTvs = await getRelatedUseCase.call(event.tv);

      emit(TvLoadedState(
        similar: relatedTvs.data,
      ));
      return;
    } catch (e) {
      emit(TvErrorState());
    }
  }
}

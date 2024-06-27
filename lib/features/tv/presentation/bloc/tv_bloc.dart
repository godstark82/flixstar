import 'package:bloc/bloc.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';
import 'package:dooflix/features/tv/domain/usecases/tv_detail_usecase.dart';
import 'package:equatable/equatable.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetailsUseCase getTvDetailsUseCase;
  TvBloc(this.getTvDetailsUseCase) : super(TvLoadingState()) {
    on<LoadTvEvent>((event, emit) async {
      final html = (await getTvDetailsUseCase.call(event.tv)).data!;
      emit(TvLoadedState(html: html.source!));
    });
  }
}

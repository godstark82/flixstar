import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/domain/usecases/tv_detail_usecase.dart';
import 'package:equatable/equatable.dart';
part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetailsUseCase getTvDetailsUseCase;

  TvBloc(this.getTvDetailsUseCase) : super(TvLoadingState()) {
    on<LoadTvEvent>(_onLoadTvDetail);
  }

  void _onLoadTvDetail(LoadTvEvent event, Emitter<TvState> emit) async {
    emit(TvLoadingState());

    const int maxRetries = 3;
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        log('Attempting to get TV details... Attempt: ${retryCount + 1}');
        final tvDetailResult = await getTvDetailsUseCase.call(event.tv);

        if (tvDetailResult is DataSuccess<TvModel>) {
          emit(TvLoadedState(html: tvDetailResult.data?.source!));
          return;
        } else {
          retryCount++;
          log('Retry Count: $retryCount');
          if (retryCount >= maxRetries) {
            emit(TvErrorState());
            return;
          }
        }
      } catch (e) {
        log('Retry Count: $retryCount');
        log('Exception occurred: $e. Retrying... ($retryCount/$maxRetries)');
        retryCount++;
        if (retryCount >= maxRetries) {
          log('Maximum retry attempts reached. Returning TvErrorState.');
          emit(TvErrorState());
          return;
        }

        await Future.delayed(
            Duration(milliseconds: 300)); // Add a delay before retrying
      }
    }
  }
}

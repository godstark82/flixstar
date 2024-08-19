import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/core/resources/data_state.dart';
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

    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        log('Attempting to get TV details... Attempt: ${retryCount + 1}');
        final tvDetailResult = await getTvDetailsUseCase.call(event.tv);
        final relatedTvs = await getRelatedUseCase.call(event.tv);

        if (tvDetailResult is DataSuccess<TvModel>) {
          emit(TvLoadedState(
              html: tvDetailResult.data?.source, similar: relatedTvs.data));
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

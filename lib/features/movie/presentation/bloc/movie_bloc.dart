import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/domain/usecases/movie_detail_usercase.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_state.dart';
import 'package:flixstar/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:startapp_sdk/startapp.dart';

part 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetailUseCase _getMovieDetailUseCase;

  MovieBloc(this._getMovieDetailUseCase) : super(MovieLoadingState()) {
    on<LoadMovieDetailEvent>((event, emit) async {
      emit(MovieLoadingState());
      try {

        // initialisation
        final startAppSdk = sl<StartAppSdk>();
        final html = (await _getMovieDetailUseCase.call(event.movie)).data;

        // source null handling
        log(html != null ? 'html found' : 'NOT AVAILABLE');
        if (html == null) {
          emit(MovieErrorState('Movie not found'));
          return;
        }

        // state emit
        emit(MovieLoadedState(sourceHtml: html.source));
      } catch (e) {
        log('Can\'t load html ${e.toString()}');
        emit(MovieErrorState(e.toString()));
      }
    });
  }
}

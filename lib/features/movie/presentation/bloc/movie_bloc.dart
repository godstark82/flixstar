import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/movie/domain/usecases/movie_detail_usercase.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetailUseCase _getMovieDetailUseCase;

  MovieBloc(this._getMovieDetailUseCase) : super(MovieLoadingState()) {
    on<LoadMovieDetailEvent>((event, emit) async {
      try {
        final html = (await _getMovieDetailUseCase.call(event.movie)).data;
        log(html != null ? 'html found' : 'NOT AVAILABLE');
        emit(MovieLoadedState(sourceHtml: html?.source));
      } catch (e) {
        log('Can\'t load html ${e.toString()}');
        emit(MovieErrorState(e.toString()));
      }
    });
  }
}

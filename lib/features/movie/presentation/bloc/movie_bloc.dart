import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/domain/usecases/movie_detail_usercase.dart';
import 'package:flixstar/features/movie/domain/usecases/related_movies_usecase.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_state.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetailUseCase _getMovieDetailUseCase;
  final GetRelatedMoviesUseCase getRelatedMoviesUseCase;

  MovieBloc(this._getMovieDetailUseCase, this.getRelatedMoviesUseCase)
      : super(MovieLoadingState()) {
    on<LoadMovieDetailEvent>(_onLoadMovieDetail);
  }

  void _onLoadMovieDetail(
      LoadMovieDetailEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoadingState());

    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        log('Attempting to get movie detail... Attempt: ${retryCount + 1}');
        log(event.movie.id!.toString());
        // 533535
        final movieDetailResult =
            await _getMovieDetailUseCase.call(event.movie);
        final similar = await getRelatedMoviesUseCase.call(event.movie.id!);
        log('Data Fetching Done in the bloc');
        if (movieDetailResult is DataSuccess<Movie>) {
          emit(MovieLoadedState(
              sourceHtml: movieDetailResult.data?.source,
              similar: similar.data));
          return;
        } else {
          retryCount++;
          log('Retry Count: $retryCount');
          if (retryCount >= maxRetries) {
            emit(MovieErrorState('Failed to load movie source.'));
            return;
          }
        }
      } catch (e) {
        log('Retry Count: $retryCount');
        retryCount++;
        log('Exception occurred: $e. Retrying... ($retryCount/$maxRetries)');

        if (retryCount >= maxRetries) {
          log('Maximum retry attempts reached. Returning MovieErrorState.');
          emit(MovieErrorState(
              'Failed to load movie source after $maxRetries attempts.'));
          return;
        }

        await Future.delayed(
            Duration(milliseconds: 300)); // Add a delay before retrying
      }
    }
  }
}

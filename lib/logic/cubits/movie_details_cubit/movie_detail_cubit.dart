import 'dart:developer';

import 'package:dooflix/api/player_api.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/repositories/movie_repo.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_event.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailCubit() : super(LoadingMovieDetailState()) {
    on<LoadMovieDetailsEvent>(_fetchMovieDetails);
  }

  void _fetchMovieDetails(
      LoadMovieDetailsEvent event, Emitter<MovieDetailState> emit) async {
    final stopWatch = Stopwatch()..start();
    try {
      final source = await PlayerApi().videoUrl(event.id);
      emit(LoadedMovieDetailState(source));
    } catch (e) {
      emit(ErrorMovieDetailState());
      rethrow;
    }
    log('Timer took ${stopWatch.elapsedMilliseconds} ms');
  }
}

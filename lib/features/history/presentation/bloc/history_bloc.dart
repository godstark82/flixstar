// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:dooflix/features/history/data/repositories/history_repo_impl.dart';
import 'package:dooflix/features/history/presentation/bloc/history_event.dart';
import 'package:dooflix/features/history/presentation/bloc/history_state.dart';
import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepoImpl historyRepo;
  HistoryBloc(this.historyRepo) : super(LoadingHistory()) {
    on<DeleteFromHistory>(_deleteSingleItemFromHistory);
    on<LoadHistoryEvent>(_loadHistory);
    on<AddToHistoryEvent>(_addToHistory);
    on<DeleteAllHistory>(_deleteHistory);
    //
  }

  void _deleteHistory(
      DeleteAllHistory event, Emitter<HistoryState> emit) async {
    await Hive.box('library').put('history-movies', []);
    await Hive.box('library').put('history-tvs', []);
    emit(LoadedHistory([], []));
  }

  void _deleteSingleItemFromHistory(
      DeleteFromHistory event, Emitter<HistoryState> emit) async {
    if (event.movie != null) {
      await historyRepo.deleteMovie(event.movie!);
    } else if (event.tv != null) {
      await historyRepo.deleteTv(event.tv!);
    }
    List<Movie> movies = Hive.box('library').get('history-movies');
    List<TvModel> tvs = Hive.box('library').get('history-tvs');
    emit(LoadedHistory(movies, tvs));
  }

  void _loadHistory(LoadHistoryEvent event, Emitter<HistoryState> emit) async {
    List<Movie> movies = [];
    List<TvModel> tvs = [];

    movies = await historyRepo.getMovieHistory();
    tvs = await historyRepo.getTvHistory();

    log('$movies $tvs');

    emit(LoadedHistory(movies, tvs));
  }

  void _addToHistory(
      AddToHistoryEvent event, Emitter<HistoryState> emit) async {
    final List<Movie> movies = state.movies.toList();
    final List<TvModel> tvs = state.tvs.toList();
    if (event.movie != null) {
      await historyRepo.addMovieToHistory(event.movie!);
      movies.add(event.movie!);
    } else if (event.tv != null) {
      await historyRepo.addTvToHistory(event.tv!);
      tvs.add(event.tv!);
    }
    emit(LoadedHistory(movies, tvs));
  }
}

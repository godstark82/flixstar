// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:dooflix/data/repositories/history_repo.dart';
import 'package:dooflix/data/repositories/movie_repo.dart';
import 'package:dooflix/data/repositories/tv_repo.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_event.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(LoadingHistory()) {
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
      DeleteFromHistory event, Emitter<HistoryState> emit) {
    if (event.movie != null) {
      HistoryRepo().deleteMovie(event.movie!);
    } else if (event.tv != null) {
      HistoryRepo().deleteTv(event.tv!);
    }
    List<Movie> movies = Hive.box('library').get('history-movies');
    List<TvModel> tvs = Hive.box('library').get('history-tvs');
    emit(LoadedHistory(movies, tvs));
  }

  void _loadHistory(LoadHistoryEvent event, Emitter<HistoryState> emit) async {
    List<Movie> movies = [];
    List<TvModel> tvs = [];

    movies = await HistoryRepo().getMovieHistory();
    tvs = await HistoryRepo().getTvHistory();

    log('$movies $tvs');

    emit(LoadedHistory(movies, tvs));
  }

  void _addToHistory(
      AddToHistoryEvent event, Emitter<HistoryState> emit) async {
    final List<Movie> movies = state.movies.toList();
    final List<TvModel> tvs = state.tvs.toList();
    if (event.movie != null) {
      await HistoryRepo().addMovieToHistory(event.movie!);
      movies.add(event.movie!);
    } else if (event.tv != null) {
      await HistoryRepo().addTvToHistory(event.tv!);
      tvs.add(event.tv!);
    }
    emit(LoadedHistory(movies, tvs));
  }
}

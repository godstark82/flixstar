// ignore_for_file: invalid_use_of_visible_for_testing_member


import 'package:flixstar/features/library/presentation/bloc/library_event.dart';
import 'package:flixstar/features/library/presentation/bloc/library_state.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/core/const/constants.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(LoadingLibraryState()) {
    //
    _loadData();
    on<AddMovieToLibrary>(_addMovieToLibrary);
    on<RemoveMovieFromLibrary>(_removeMovieFromLibrary);
    on<AddTvToLibrary>(_addTvToLibrary);
    on<RemoveTvFromLibrary>(_removeTvFromLibrary);
  }

  void _loadData() async {
    List<Movie> libraryMovies = [];
    List<TvModel> libraryTvs = [];
    List<Map<String, dynamic>> moviesMap =
        ((await Hive.box('library').get('movies') ?? []) as List)
            .map((v) => Map<String, dynamic>.from(v))
            .toList();
    // log('$moviesMap');
    List<Map<String, dynamic>> tvsMap =
        ((await Hive.box('library').get('tvs') ?? []) as List)
            .map((v) => Map<String, dynamic>.from(v))
            .toList();
    // log('$tvsMap');
    for (var i = 0; i < moviesMap.length; i++) {
      libraryMovies.add(Movie.fromJson(moviesMap[i]));
    }
    for (var i = 0; i < tvsMap.length; i++) {
      libraryTvs.add(TvModel.fromJson(tvsMap[i]));
    }
    emit(LoadedLibraryState(movies: libraryMovies, tvs: libraryTvs));
  }

  void _addMovieToLibrary(
      AddMovieToLibrary event, Emitter<LibraryState> emit) async {
    List<Movie> updatedMovies = state.movies.toList();

    updatedMovies.add(event.movie);
    List<Map<String, dynamic>> moviesMap = [];
    for (var i = 0; i < updatedMovies.length; i++) {
      moviesMap.add(updatedMovies[i].toJson());
    }
    await Boxes.library.put('movies', moviesMap);
    // log('${Boxes.library.get('movies')}');
    emit(LoadedLibraryState(movies: updatedMovies, tvs: state.tvs));
  }

  void _removeMovieFromLibrary(
      RemoveMovieFromLibrary event, Emitter<LibraryState> emit) async {
    List<Movie> updatedMovies = state.movies.toList();
    updatedMovies.remove(event.movie);
    List<Map<String, dynamic>> moviesMap = [];
    for (var i = 0; i < updatedMovies.length; i++) {
      moviesMap.add(updatedMovies[i].toJson());
    }
    // log('${Boxes.library.get('movies')}');
    await Boxes.library.put('movies', moviesMap);
    emit(LoadedLibraryState(movies: updatedMovies, tvs: state.tvs));
  }

  void _addTvToLibrary(AddTvToLibrary event, Emitter<LibraryState> emit) async {
    List<TvModel> updatedTv = state.tvs.toList();
    updatedTv.add(event.series);
    List<Map<String, dynamic>> moviesMap = [];
    for (var i = 0; i < updatedTv.length; i++) {
      moviesMap.add(updatedTv[i].toJson());
    }
    // log('${Boxes.library.get('tvs')}');
    await Boxes.library.put('tvs', moviesMap);
    emit(LoadedLibraryState(movies: state.movies, tvs: updatedTv));
  }

  void _removeTvFromLibrary(
      RemoveTvFromLibrary event, Emitter<LibraryState> emit) async {
    List<TvModel> updatedTv = state.tvs.toList();
    updatedTv.remove(event.series);
    List<Map<String, dynamic>> moviesMap = [];
    for (var i = 0; i < updatedTv.length; i++) {
      moviesMap.add(updatedTv[i].toJson());
    }
    await Boxes.library.put('tvs', moviesMap);
    // log('${Boxes.library.get('movies')}');
    emit(LoadedLibraryState(movies: state.movies, tvs: updatedTv));
  }
}

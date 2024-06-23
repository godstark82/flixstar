import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/source_model.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class LoadingMovieDetailState extends MovieDetailState {}

class LoadedMovieDetailState extends MovieDetailState {
  final MediaSource? source;
  const LoadedMovieDetailState(this.source);
}

class ErrorMovieDetailState extends MovieDetailState {}

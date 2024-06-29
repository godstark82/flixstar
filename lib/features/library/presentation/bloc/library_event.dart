import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

class LoadLibrary extends LibraryEvent {}

class AddMovieToLibrary extends LibraryEvent {
  final Movie movie;

  const AddMovieToLibrary(this.movie);
}

class RemoveMovieFromLibrary extends LibraryEvent {
  final Movie movie;

  const RemoveMovieFromLibrary(this.movie);
}

class AddTvToLibrary extends LibraryEvent {
  final TvModel series;

  const AddTvToLibrary(this.series);
}

class RemoveTvFromLibrary extends LibraryEvent {
  final TvModel series;

  const RemoveTvFromLibrary(this.series);
}

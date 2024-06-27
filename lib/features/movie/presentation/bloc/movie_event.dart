part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetailEvent extends MovieEvent {
  final Movie movie;

  const LoadMovieDetailEvent({required this.movie});
}

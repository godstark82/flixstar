import 'package:equatable/equatable.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';

abstract class MovieState extends Equatable {
  final String? sourceHtml;
  final List<Movie>? similar;
  const MovieState({this.sourceHtml, this.similar});
  @override
  List<Object> get props => [];
}

class MovieLoadingState extends MovieState {
  const MovieLoadingState() : super();
}

class MovieLoadedState extends MovieState {
  const MovieLoadedState({required super.sourceHtml, required super.similar});
}

class MovieErrorState extends MovieState {
  final String msg;

  const MovieErrorState(this.msg) : super();
}

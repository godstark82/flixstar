import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable {
  final List<Movie> movies;
  final List<TvModel> tvs;

  const HistoryState({required this.movies, required this.tvs});

  @override
  List<Object?> get props => [movies, tvs];
}

class LoadingHistory extends HistoryState {
  const LoadingHistory() : super(movies: const [], tvs: const []);
}

class LoadedHistory extends HistoryState {
  const LoadedHistory(List<Movie> movies, List<TvModel> tvs)
      : super(movies: movies, tvs: tvs);
}

class ErrorHistory extends HistoryState {
  final String message;
  const ErrorHistory(this.message) : super(movies: const [], tvs: const []);
}

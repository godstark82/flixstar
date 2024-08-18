import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';

abstract class LibraryState extends Equatable {
  final List<Movie> movies;
  final List<TvModel> tvs;
  const LibraryState({required this.movies, required this.tvs});

  @override
  List<Object> get props => [movies, tvs];
}

class LoadingLibraryState extends LibraryState {
  const LoadingLibraryState() : super(movies: const [], tvs: const []);
}

class LoadedLibraryState extends LibraryState {
  const LoadedLibraryState({required super.movies, required super.tvs});
}

part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialState extends SearchState {}

final class LoadingSearchState extends SearchState {}

final class LoadedSearchState extends SearchState {
  final List<Movie> fetchedMovies;
  final List<TvModel> fetchedTv;
  final BuiltList<Anime> fetchedAnimes;
  const LoadedSearchState(this.fetchedMovies,
      {required this.fetchedTv, required this.fetchedAnimes});
}

final class ErrorSearchState extends SearchState {}

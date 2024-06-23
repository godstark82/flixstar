import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProviderState extends Equatable {
  const ProviderState();

  @override
  List<Object> get props => [];
}

class LoadingProviderState extends ProviderState {}

class ErrorProviderState extends ProviderState {
  final String message;
  const ErrorProviderState({required this.message});
}

class LoadedProviderState extends ProviderState {
  final List<Movie> movies;
  final List<TvModel> tvs;
  const LoadedProviderState({required this.movies, required this.tvs});
}

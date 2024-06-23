import 'package:dooflix/data/models/genre_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

abstract class TvHomeState extends Equatable {
  const TvHomeState();

  @override
  List<Object> get props => [];
}

class LoadingHomeTvState extends TvHomeState {}

class ErrorHomeTvState extends TvHomeState {}

class LoadedHomeTvState extends TvHomeState {
  final List<TvModel> topRatedTvs;
  final List<GenreTvModel> genres;

  const LoadedHomeTvState({required this.genres, required this.topRatedTvs});
}

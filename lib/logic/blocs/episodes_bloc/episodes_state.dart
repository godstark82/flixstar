import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:equatable/equatable.dart';

abstract class EpisodeStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingEpisodeState extends EpisodeStates {}

class LoadedEpisodeState extends EpisodeStates {
  final List<TvEpisode> episodes;
  LoadedEpisodeState({required this.episodes });

  @override
  List<Object?> get props => [episodes];
}

class ErrorEpisodeState extends EpisodeStates {
  final String message;
  ErrorEpisodeState({required this.message});
}

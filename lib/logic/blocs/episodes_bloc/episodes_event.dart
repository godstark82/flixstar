import 'package:equatable/equatable.dart';
import 'package:dooflix/data/models/tv_details_model.dart';

abstract class EpisodesEvent extends Equatable {
  const EpisodesEvent();

  @override
  List<Object?> get props => [];
}

class OpenSeasonEpisodesEvent extends EpisodesEvent {
  final int tvId;
  final int seasonId;
  const OpenSeasonEpisodesEvent({required this.seasonId, required this.tvId});
}

part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadVideoEvent extends VideoPlayerEvent {
  final int id;
  final int? episode;
  final int? season;
  const LoadVideoEvent({required this.id, this.episode, this.season});
}

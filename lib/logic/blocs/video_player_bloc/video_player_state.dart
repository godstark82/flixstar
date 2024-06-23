part of 'video_player_bloc.dart';

sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

final class LoadingVideoState extends VideoPlayerState {}

final class LoadedVideoState extends VideoPlayerState {
  final BetterPlayerController? betterController;
  final int id;
  final int? season;
  final int? episode;

  const LoadedVideoState(
      {required this.id, this.season, this.episode, this.betterController});
}

final class ErrorVideoState extends VideoPlayerState {}

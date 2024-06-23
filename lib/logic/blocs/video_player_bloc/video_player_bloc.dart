import 'package:bloc/bloc.dart';
import 'package:dooflix/api/player_api.dart';
import 'package:dooflix/data/models/source_model.dart';
import 'package:dooflix/data/models/subtitle_config.dart';
import 'package:dooflix/presentation/screens/settings/components/subtitles.dart';
import 'package:dooflix/presentation/widgets/custom_controls.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:river_player/river_player.dart';
import 'package:video_player/video_player.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(LoadingVideoState()) {
    on<LoadVideoEvent>(_loadVideo);
  }

  void _loadVideo(LoadVideoEvent event, Emitter<VideoPlayerState> emit) async {
    try {
      PlayerApi api = PlayerApi();
      final source = await api.videoUrl(event.id,
          episode: event.episode, season: event.season);
      // final subConfig = CustomSubtitleConfiguration.fromJson(
      // (await Hive.box('settings').get('subtitles') as Map)
      // .cast<String, dynamic>());
      final betterController = _buildController(source!,
          subtitleCofig: CustomSubtitleConfiguration(
              bgColor: Colors.black.withOpacity(0.8),
              fontSize: 16,
              textColor: Colors.white));

      emit(LoadedVideoState(
        id: event.id,
        episode: event.episode,
        season: event.season,
        betterController: betterController,
      ));
    } catch (ex) {
      emit(ErrorVideoState());
      rethrow;
    }
  }

  BetterPlayerController _buildController(MediaSource source,
      {CustomSubtitleConfiguration? subtitleCofig}) {
    return BetterPlayerController(
      BetterPlayerConfiguration(
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ],
        aspectRatio: 16 / 9,
        autoPlay: true,
        autoDispose: true,
        expandToFill: true,
        fullScreenByDefault: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableFullscreen: false,
          enablePip: true,
          progressBarHandleColor: Colors.green,
          progressBarPlayedColor: Colors.green,
          progressBarBufferedColor: Colors.teal,
          showControlsOnInitialize: true,
          enableMute: false,
          backgroundColor: Colors.black,
          playerTheme: BetterPlayerTheme.cupertino,
          customControlsBuilder: (controller, onPlayerVisibilityChanged) {
            return CustomControlsWidget(
              controller: controller,
              onControlsVisibilityChanged: onPlayerVisibilityChanged,
            );
          },
        ),
        //!!!! Subtitle Configuration should be as user wants
        subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
            backgroundColor: subtitleCofig!.bgColor,
            fontColor: subtitleCofig.textColor,
            fontSize: subtitleCofig.fontSize),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, source.url!,
          asmsTrackNames: ["Low quality", "Medium Quality", "High Quality"],
          useAsmsAudioTracks: true,
          // useAsmsSubtitles: true,
          useAsmsTracks: true,
          liveStream: false,
          subtitles: (source.subtitles != null && source.subtitles!.isNotEmpty)
              ? source.subtitles!
                  .map((subtitle) => BetterPlayerSubtitlesSource(
                      // selectedByDefault: true,
                      type: BetterPlayerSubtitlesSourceType.network,
                      name: subtitle.name,
                      urls: [subtitle.url]))
                  .toList()
              : []),
    );
  }
}

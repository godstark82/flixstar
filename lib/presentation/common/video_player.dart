import 'dart:developer';
import 'dart:io';
import 'package:dooflix/logic/blocs/video_player_bloc/video_player_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:river_player/river_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final int id;
  final int? season;
  final int? episode;
  final String url;
  const VideoPlayerScreen(
      {super.key,
      required this.id,
      this.episode,
      this.season,
      required this.url});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  String get url => widget.url;

  @override
  void initState() {
    context.read<VideoPlayerBloc>().add(LoadVideoEvent(
        id: widget.id, episode: widget.episode, season: widget.season));
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    // log('SEASON ID IS: ${widget.id},\n EPISODE ID IS: ${widget.episode},\n SEASON ID IS: ${widget.season}');
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // context.go('/');
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
              builder: (context, state) {
            if (state is LoadedVideoState) {
              return BetterPlayer(controller: state.betterController!);
            } else if (state is LoadingVideoState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                  child:
                      Text('Not Available Yet \n We\'ll try to add it soon.'));
            }
          }),
        ),
      ),
    );
  }
}

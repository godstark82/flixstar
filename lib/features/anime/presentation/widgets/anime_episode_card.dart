import 'dart:developer';

import 'package:dooflix/core/routes/routes.dart';
import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/core/utils/constants.dart';
import 'package:dooflix/features/anime/data/models/source_model.dart';
import 'package:dooflix/presentation/common/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:river_player/river_player.dart';

class AnimeEpisodeCard extends StatelessWidget {
  final Anime anime;
  final AnimeSource source;
  final int index;

  const AnimeEpisodeCard(
      {super.key,
      required this.anime,
      required this.source,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${source.episodeId}'),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (source.url360p != null)
                          TextButton(
                              onPressed: () {
                                toAnimeVideoPlayer(source.url360p!);
                              },
                              child: Text('360p')),
                        if (source.url480p != null)
                          TextButton(
                              onPressed: () {
                                toAnimeVideoPlayer(source.url480p!);
                              },
                              child: Text('480p')),
                        if (source.url720p != null)
                          TextButton(
                              onPressed: () {
                                toAnimeVideoPlayer(source.url720p!);
                              },
                              child: Text('720p')),
                        if (source.url1080p != null)
                          TextButton(
                              onPressed: () {
                                toAnimeVideoPlayer(source.url1080p!);
                              },
                              child: Text('1080p')),
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}

void toAnimeVideoPlayer(String url) async {
  Get.back();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    log('Orientation set \n Opening Player');
  });

  await Get.to(() => Material(
        child: BetterPlayer.network(
          url,
          betterPlayerConfiguration:
              BetterPlayerConfiguration(deviceOrientationsOnFullScreen: [
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ], autoDetectFullscreenDeviceOrientation: false),
        ),
      ));
}

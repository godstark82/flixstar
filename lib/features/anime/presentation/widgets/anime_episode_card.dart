
import 'package:dooflix/features/anime/data/models/source_model.dart';
import 'package:dooflix/common/url_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jikan_api/jikan_api.dart';

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
  final String playerUrl =
      'https://bharadwajpro.github.io/m3u8-player/player/#$url';
  print(playerUrl);
  await Get.to(() => WebVideoPlayer(html: playerUrl));
}

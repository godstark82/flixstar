import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/core/utils/constants.dart';
import 'package:dooflix/presentation/common/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EpisodeCard extends StatelessWidget {
  final int tvId;
  final TvEpisode episode;
  final String url;

  const EpisodeCard(
      {super.key,
      required this.episode,
      required this.tvId,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                      url: url,
                      id: tvId,
                      season: episode.seasonNumber,
                      episode: episode.episodeNumber,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(12),
        height: context.height * 0.175,
        width: context.width * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(episode.stillPath!.endsWith('null')
                  ? Constants.backdroPlaceholder
                  : episode.stillPath.toString()),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.7)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 0),
              Center(
                child: Icon(Icons.play_circle),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'S${episode.seasonNumber} E${episode.episodeNumber}${episode.name}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

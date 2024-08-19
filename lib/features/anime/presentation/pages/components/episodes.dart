import 'package:flixstar/api/gogo_api.dart';
import 'package:flixstar/core/common/widgets/heading_2.dart';
import 'package:flixstar/core/routes/routes.dart';
import 'package:flixstar/features/anime/data/models/source_model.dart';
import 'package:flixstar/features/anime/presentation/widgets/anime_episode_card.dart';
import 'package:flixstar/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:load_items/load_items.dart';

SliverToBoxAdapter buildAnimeEpisodesList(BuildContext context, Anime anime) {
  return SliverToBoxAdapter(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Heading2(text: 'All Episodes'),
            TextButton(
                onPressed: () => DNavigator.toAllEpisodes(anime),
                child: Text('Show all'))
          ],
        ),
        SizedBox(
            height: 300,
            child: LoadItems<AnimeSource>(
                type: LoadItemsType.list,
                itemsLoader: (List<AnimeSource> currentItems) async {
                  List<AnimeSource> sources = [];

                  final go = sl<GoAnime>();

                  if (currentItems.isEmpty) {
                    sources =
                        await go.getEpisodesLinksOfAnime(anime, count: 10);
                  }
                  return sources;
                },
                itemBuilder: (context, source, index) {
                  return AnimeEpisodeCard(
                      anime: anime, source: source, index: index);
                })),
      ],
    ),
  ));
}

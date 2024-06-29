// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixstar/api/gogo_api.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/core/routes/routes.dart';
import 'package:flixstar/features/anime/data/models/source_model.dart';
import 'package:flixstar/features/anime/presentation/widgets/anime_episode_card.dart';
import 'package:flixstar/injection_container.dart';
import 'package:flixstar/features/movie/presentation/pages/movie_page.dart';
import 'package:flixstar/common/heading_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:load_items/load_items.dart';

class AnimeDetailsPage extends StatelessWidget {
  final Anime anime;
  const AnimeDetailsPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _buildAppBar(context, anime),
        _buildOverview(anime),
        _buildotherOptions(context, anime),
        if (streamMode) _buildEpisodes(context, anime),
      ],
    ));
  }

  SliverAppBar _buildAppBar(BuildContext context, Anime anime) {
    return SliverAppBar(
      primary: true,

      forceMaterialTransparency: true,
      // backgroundColor: Colors.black,
      expandedHeight: context.height * 0.5,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(movie.title ?? movie.name.toString()),
        collapseMode: CollapseMode.parallax,
        background: Container(
          // filter: ImageFilter.blur(sigmaX: 12,sigmaY: 12),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(anime.imageUrl.toString()),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
                decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.2),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.transparent.withOpacity(0.2),
                      Colors.black.withOpacity(0.9),
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                        imageUrl: anime.imageUrl.toString(),
                        height: context.height * 0.25),
                    SizedBox(height: 15),
                    Text(anime.titleEnglish ?? anime.title.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      DetailsChip(text: anime.aired.toString().toUpperCase()),
                      SizedBox(width: 15),
                      DetailsChip(
                          text:
                              (DateTime.tryParse(anime.aired.toString())?.year)
                                  .toString()),
                      SizedBox(width: 15),
                      DetailsChip(
                          text: anime.airing == true ? 'Airing' : 'Not Airing'),
                    ]),
                    SizedBox(
                      height: 25,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildOverview(Anime anime) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(anime.titleEnglish.toString(),
              maxLines: 4, overflow: TextOverflow.ellipsis)),
    );
  }

  SliverToBoxAdapter _buildotherOptions(BuildContext context, Anime anime) {
    return SliverToBoxAdapter(
      child: SizedBox(
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OtherOptions(
                  iconData: Icon(Icons.movie_outlined), text: 'Trailer'),
              OtherOptions(iconData: Icon(Icons.report_sharp), text: 'Report'),
              OtherOptions(iconData: Icon(Icons.share), text: 'Share')
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildEpisodes(BuildContext context, Anime anime) {
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
                    GoAnime go = GoAnime(sl());

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
}

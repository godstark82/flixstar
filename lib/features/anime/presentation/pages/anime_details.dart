import 'package:flixstar/common/widgets/ads/banner.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/anime/presentation/pages/components/app_bar.dart';
import 'package:flixstar/features/anime/presentation/pages/components/episodes.dart';
import 'package:flixstar/features/anime/presentation/pages/components/other_options.dart';
import 'package:flixstar/features/anime/presentation/pages/components/overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeDetailsPage extends StatelessWidget {
  final Anime anime;
  const AnimeDetailsPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        buildAnimeAppBar(context, anime),
        buildAnimeOverview(anime),
        buildSliverBannerAd(),
        buildAnimeOtherOptions(context, anime),
        if (streamMode) buildAnimeEpisodesList(context, anime),
      ],
    ));
  }
}

import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/anime/presentation/pages/components/app_bar.dart';
import 'package:flixstar/features/anime/presentation/pages/components/episodes.dart';
import 'package:flixstar/features/anime/presentation/pages/components/other_options.dart';
import 'package:flixstar/features/anime/presentation/pages/components/overview.dart';
import 'package:flixstar/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:startapp_sdk/startapp.dart';

class AnimeDetailsPage extends StatefulWidget {
  final Anime anime;
  const AnimeDetailsPage({super.key, required this.anime});

  @override
  State<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}

class _AnimeDetailsPageState extends State<AnimeDetailsPage> {
  final startApp = sl<StartAppSdk>();
  StartAppBannerAd? bannerAd;

  @override
  void initState() {
    startApp.loadBannerAd(StartAppBannerType.BANNER).then((ad) {
      bannerAd = ad;
      setState(() {});
    }).onError((error, stackTrace) {
      debugPrint("Error loading Banner ad: $error");
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        buildAnimeAppBar(context, widget.anime),
        buildAnimeOverview(widget.anime),
        buildBannerAD(),
        buildAnimeOtherOptions(context, widget.anime),
        if (streamMode) buildAnimeEpisodesList(context, widget.anime),
      ],
    ));
  }

  SliverToBoxAdapter buildBannerAD() {
    return SliverToBoxAdapter(
      child: bannerAd != null
          ? SizedBox(
              height: 50,
              child: StartAppBanner(bannerAd!),
            )
          : SizedBox(),
    );
  }
}

import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/anime/presentation/pages/components/app_bar.dart';
import 'package:flixstar/features/anime/presentation/pages/components/episodes.dart';
import 'package:flixstar/features/anime/presentation/pages/components/other_options.dart';
import 'package:flixstar/features/anime/presentation/pages/components/overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeDetailsPage extends StatefulWidget {
  final Anime anime;
  const AnimeDetailsPage({super.key, required this.anime});

  @override
  State<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}

class _AnimeDetailsPageState extends State<AnimeDetailsPage> {
  BannerAd bannerAd = BannerAd(
    adUnitId: bannerId1,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) => print('BannerAd loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('BannerAd failed to load: $error');
      },
    ),
  );

  @override
  void initState() {
    bannerAd.load();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd.dispose();
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
      child: SizedBox(
        height: 50,
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}

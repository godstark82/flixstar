import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/presentation/widgets/app_bar.dart';

import 'package:flixstar/features/tv/presentation/widgets/overview.dart';
import 'package:flixstar/features/tv/presentation/widgets/related_tvs.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TvDetailsPage extends StatefulWidget {
  final TvModel tv;

  const TvDetailsPage({super.key, required this.tv});

  @override
  State<TvDetailsPage> createState() => _TvDetailsPageState();
}

class _TvDetailsPageState extends State<TvDetailsPage> {
  BannerAd? bannerAd = BannerAd(
    adUnitId: bannerId2,
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
    bannerAd?.load();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildAppBar(context, widget.tv),
        buildTVOverview(widget.tv),
        buildBannerAd(),
        buildSimilarTvs(context)
      ],
    );
  }

  SliverToBoxAdapter buildBannerAd() {
    return SliverToBoxAdapter(
      child: bannerAd == null
          ? SizedBox()
          : SizedBox(height: 50, child: AdWidget(ad: bannerAd!)),
    );
  }
}

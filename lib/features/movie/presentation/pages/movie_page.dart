import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/movie/presentation/widgets/app_bar.dart';
import 'package:flixstar/features/movie/presentation/widgets/overview.dart';
import 'package:flixstar/features/movie/presentation/widgets/related_movie.dart';
import 'package:flixstar/features/tv/presentation/widgets/related_tvs.dart';
import 'package:flutter/material.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
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
    return CustomScrollView(
      slivers: [
        buildAppBar(context, widget.movie),
        buildOverview(widget.movie),
        buildBannerAD(bannerAd),
        buildSimilarMovies(context)
      ],
    );
  }
}

SliverToBoxAdapter buildBannerAD(BannerAd? bannerAd) {
  return SliverToBoxAdapter(
    child: bannerAd == null
        ? SizedBox()
        : SizedBox(height: 50, child: AdWidget(ad: bannerAd)),
  );
}

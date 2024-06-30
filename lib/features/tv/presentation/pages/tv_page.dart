import 'package:flixstar/common/widgets/ads/banner.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/presentation/widgets/app_bar.dart';
import 'package:flixstar/features/tv/presentation/widgets/other_options.dart';
import 'package:flixstar/features/tv/presentation/widgets/overview.dart';
import 'package:flutter/material.dart';

class TvDetailsPage extends StatelessWidget {
  final TvModel tv;

  const TvDetailsPage({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildAppBar(context, tv),
        buildTVOverview(tv),
        buildTVOtherOptions(context, tv),
        buildSliverBannerAd(),
      ],
    );
  }
}

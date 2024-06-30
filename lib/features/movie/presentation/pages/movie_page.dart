import 'package:flixstar/common/widgets/ads/banner.dart';
import 'package:flixstar/features/movie/presentation/widgets/app_bar.dart';
import 'package:flixstar/features/movie/presentation/widgets/other_options.dart';
import 'package:flixstar/features/movie/presentation/widgets/overview.dart';
import 'package:flutter/material.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildAppBar(context, movie),
        buildOverview(movie),
        buildSliverBannerAd(),
        buildotherOptions(context, movie),
      ],
    );
  }
}

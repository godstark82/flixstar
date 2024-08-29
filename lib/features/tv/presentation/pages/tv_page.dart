import 'dart:io';

import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/presentation/widgets/app_bar.dart';

import 'package:flixstar/features/tv/presentation/widgets/overview.dart';
import 'package:flixstar/features/tv/presentation/widgets/related_tvs.dart';
import 'package:flixstar/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:startapp_sdk/startapp.dart';

class TvDetailsPage extends StatefulWidget {
  final TvModel tv;

  const TvDetailsPage({super.key, required this.tv});

  @override
  State<TvDetailsPage> createState() => _TvDetailsPageState();
}

class _TvDetailsPageState extends State<TvDetailsPage> {
  final startAppSdk = sl<StartAppSdk>();
  StartAppBannerAd? bannerAd;

  @override
  void initState() {
    if (!kIsWeb) {
      if (!Platform.isWindows) {
        startAppSdk.loadBannerAd(StartAppBannerType.BANNER).then((bannerAd) {
          setState(() {
            this.bannerAd = bannerAd;
          });
        }).onError<StartAppException>((ex, stackTrace) {
          debugPrint("Error loading Banner ad: ${ex.message}");
        }).onError((error, stackTrace) {
          debugPrint("Error loading Banner ad: $error");
        });
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      if (!Platform.isWindows) {
        bannerAd?.dispose();
      }
    }
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
    if (!kIsWeb) {
      if (!Platform.isWindows) {
        return SliverToBoxAdapter(
          child: bannerAd == null
              ? SizedBox()
              : SizedBox(height: 50, child: StartAppBanner(bannerAd!)),
        );
      }
    }
    return SliverToBoxAdapter(child: SizedBox());
  }
}

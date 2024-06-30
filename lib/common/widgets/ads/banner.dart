import 'package:flixstar/common/func/load_ad.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flutter/widgets.dart';
import 'package:startapp_sdk/startapp.dart';

SliverToBoxAdapter buildSliverBannerAd() {
  return SliverToBoxAdapter(
      child: FutureBuilder(
          future: loadBannerAd(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null && showAds) {
              return StartAppBanner(snapshot.data!);
            }
            return SizedBox();
          }));
}

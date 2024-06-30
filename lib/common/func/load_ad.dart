import 'package:flixstar/injection_container.dart';
import 'package:startapp_sdk/startapp.dart';

Future<StartAppBannerAd?> loadBannerAd() async {
  final startAppSdk = sl<StartAppSdk>();
  return await startAppSdk.loadBannerAd(StartAppBannerType.BANNER);
}

Future<StartAppInterstitialAd?> loadInterstitialAd() async {
  final startAppSdk = sl<StartAppSdk>();
  return await startAppSdk.loadInterstitialAd();
}

Future<StartAppRewardedVideoAd?> loadRewardedAd() async {
  final startAppSdk = sl<StartAppSdk>();
  return await startAppSdk.loadRewardedVideoAd();
}

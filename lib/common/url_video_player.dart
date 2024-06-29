import 'package:easy_web_view/easy_web_view.dart';
import 'package:flixstar/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:startapp_sdk/startapp.dart';

class WebVideoPlayer extends StatefulWidget {
  final String html;
  const WebVideoPlayer({super.key, required this.html});

  @override
  State<WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  StartAppInterstitialAd? interstitialAd;
  @override
  void initState() {
    super.initState();
  }

  void loadInterstitialAd() async {
    final startAppSdk = sl<StartAppSdk>();
    await startAppSdk.loadInterstitialAd().then((ad) {
      interstitialAd = ad;
    }).onError((err, trace) {
      print(err);
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    interstitialAd?.show().then((shown) {
      if (shown) {
        interstitialAd = null;
        loadInterstitialAd();
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return EasyWebView(
      src: widget.html,
      width: context.height,
      height: context.width,
      options:
          WebViewOptions(browser: BrowserWebViewOptions(allowFullScreen: true)),
    );
  }
}

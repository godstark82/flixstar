import 'dart:developer';
import 'dart:io';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MoviePlayer extends StatefulWidget {
  final String html;
  const MoviePlayer({super.key, required this.html});

  @override
  State<MoviePlayer> createState() => _WebVideoPlayerState();
}

// COmment
//

class _WebVideoPlayerState extends State<MoviePlayer> {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    _createInterstitialAd();

    super.initState();
  }

  void _createInterstitialAd() {
    if (!kIsWeb && !Platform.isWindows) {
      InterstitialAd.load(
          adUnitId: intersititialId1,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              print('$ad loaded');
              _interstitialAd = ad;
              _numInterstitialLoadAttempts = 0;
              _interstitialAd!.setImmersiveMode(true);
            },
            onAdFailedToLoad: (LoadAdError error) {
              print('InterstitialAd failed to load: $error.');
              _numInterstitialLoadAttempts += 1;
              _interstitialAd = null;
              if (_numInterstitialLoadAttempts < 3) {
                _createInterstitialAd();
              }
            },
          ));
    }
  }

  void _showInterstitialAd() {
    if (!kIsWeb) {
      if (!Platform.isWindows) {
        if (_interstitialAd == null) {
          log('Warning: attempt to show interstitial before loaded.');
          return;
        }
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) =>
              log('ad onAdShowedFullScreenContent.'),
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            log('$ad onAdDismissedFullScreenContent.');
            ad.dispose();
            _createInterstitialAd();
          },
          onAdFailedToShowFullScreenContent:
              (InterstitialAd ad, AdError error) {
            log('$ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
            _createInterstitialAd();
          },
        );
        _interstitialAd!.show();
        _interstitialAd = null;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _showInterstitialAd();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return buildEZWV(context, widget.html);
  }
}

EasyWebView buildEZWV(BuildContext context, String url) {
  return EasyWebView(
    src: url,
    width: context.height,
    height: context.width,
    options: WebViewOptions(
      navigationDelegate: (WebNavigationRequest request) {
        return WebNavigationDecision.prevent;
      },
      browser: BrowserWebViewOptions(allowFullScreen: true),
    ),
  );
}

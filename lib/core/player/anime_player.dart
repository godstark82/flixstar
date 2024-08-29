import 'dart:developer';
import 'dart:io';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flixstar/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:startapp_sdk/startapp.dart';

class AnimePlayer extends StatefulWidget {
  final String source;
  const AnimePlayer({super.key, required this.source});

  @override
  State<AnimePlayer> createState() => _WebVideoPlayerState();
}

// COmment
//

class _WebVideoPlayerState extends State<AnimePlayer> {
  final startApp = sl<StartAppSdk>();
  StartAppInterstitialAd? _interstitialAd;

  @override
  void initState() {
    _createInterstitialAd();

    super.initState();
  }

  void _createInterstitialAd() {
    if (!kIsWeb && !Platform.isWindows) {
      startApp.loadInterstitialAd().then((ad) {
        setState(() {
          _interstitialAd = ad;
        });
      }).onError((ex, stackTrace) {
        _interstitialAd = null;
        debugPrint("Error Loading Interstitial Ad: $ex");
      });
    }
  }

  void _showInterstitialAd() {
    if (!kIsWeb) {
      if (!Platform.isWindows) {
        if (_interstitialAd == null) {
          log('Warning: attempt to show interstitial before loaded.');
          return;
        }
        if (_interstitialAd != null) {
            _interstitialAd!.show().then((shown) {
              if (shown) {
                setState(() {
                  // NOTE interstitial ad can be shown only once
                  _interstitialAd = null;

                  // NOTE load again
                  _createInterstitialAd();
                });
              }

              return null;
            }).onError((error, stackTrace) {
              debugPrint("Error showing Interstitial ad: $error");
            });
          }
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
    return buildEZWV(context, widget.source);
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

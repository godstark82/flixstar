import 'dart:developer';

import 'package:flixstar/core/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class VideoPlayer extends StatefulWidget {
  final String html;
  const VideoPlayer({super.key, required this.html});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late WebViewControllerPlus _controller;
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: rewardedId1,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            log('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < 3) {
              _createRewardedAd();
            }
          },
        ));
  }

  void setUpController() {
    _controller = WebViewControllerPlus();
    if (widget.html.isURL) _controller.loadFlutterAssetServer(widget.html);
    if (!widget.html.isURL) _controller.loadHtmlString(widget.html);
    _controller.enableZoom(true);
    _controller.canGoBack();
    _controller.setBackgroundColor(Colors.black);
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    setUpController();
    _createRewardedAd();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();

    _rewardedAd?.dispose();
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (v) async {
          if (await _controller.currentUrl() == 'https://vidsrc.to' ||
              await _controller.currentUrl() == 'https://vidsrc.to/') {
            setState(() {
              setUpController();
            });
          } else {
            Get.back();
          }
        },
        child: Scaffold(body: Builder(builder: (context) {
          _showRewardedAd();
          return WebViewWidget(controller: _controller);
        })));
  }
}

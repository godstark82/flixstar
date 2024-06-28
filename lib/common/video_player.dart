import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class VideoPlayer extends StatefulWidget {
  final String html;
  const VideoPlayer({super.key, required this.html});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late WebViewControllerPlus _controller;

  void setUpController() {
    _controller = WebViewControllerPlus();
    if (widget.html.isURL) _controller.loadFlutterAssetServer(widget.html);
    if(!widget.html.isURL) _controller.loadHtmlString(widget.html);
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

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
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
        child: Scaffold(body: WebViewWidget(controller: _controller)));
  }
}

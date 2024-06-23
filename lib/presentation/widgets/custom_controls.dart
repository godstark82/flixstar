import 'package:flutter/material.dart';
import 'package:river_player/river_player.dart';

class CustomControlsWidget extends StatefulWidget {
  final BetterPlayerController? controller;
  final Function(bool visibility)? onControlsVisibilityChanged;

  const CustomControlsWidget({
    super.key,
    this.controller,
    this.onControlsVisibilityChanged,
  });

  @override
  State<CustomControlsWidget> createState() => _CustomControlsWidgetState();
}

class _CustomControlsWidgetState extends State<CustomControlsWidget> {
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller!.addEventsListener(_onPlayerEvent);
  }

  void _onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      setState(() {
        _sliderValue = event.parameters!['position'] as double;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      widget.controller!.isFullScreen
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                onTap: () => setState(() {
                  if (widget.controller!.isFullScreen) {
                    widget.controller!.exitFullScreen();
                  } else {
                    widget.controller!.enterFullScreen();
                  }
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          Duration? videoDuration = await widget
                              .controller!.videoPlayerController!.position;
                          setState(() {
                            if (widget.controller!.isPlaying()!) {
                              Duration rewindDuration = Duration(
                                  seconds: (videoDuration!.inSeconds - 2));
                              if (rewindDuration <
                                  widget.controller!.videoPlayerController!
                                      .value.duration!) {
                                widget.controller!.seekTo(Duration(seconds: 0));
                              } else {
                                widget.controller!.seekTo(rewindDuration);
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.fast_rewind,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.controller!.isPlaying()!) {
                              widget.controller!.pause();
                            } else {
                              widget.controller!.play();
                            }
                          });
                        },
                        child: Icon(
                          widget.controller!.isPlaying()!
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      // Add more controls here as needed
                    ],
                  ),
                  // Seek slider
                  Slider(
                    value: _sliderValue,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (newValue) {
                      final newDuration = Duration(
                        milliseconds: (newValue *
                                widget.controller!.videoPlayerController!.value
                                    .duration!.inMilliseconds)
                            .toInt(),
                      );
                      widget.controller!.seekTo(newDuration);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

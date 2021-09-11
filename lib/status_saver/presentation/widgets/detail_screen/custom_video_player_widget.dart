import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CustomVideoPlayerWidget extends StatefulWidget {
  CustomVideoPlayerWidget({
    Key? key,
    this.height,
    required this.path,
  }) : super(key: key);

  final double? height;
  final String path;

  @override
  _CustomVideoPlayerWidgetState createState() =>
      _CustomVideoPlayerWidgetState();
}

class _CustomVideoPlayerWidgetState extends State<CustomVideoPlayerWidget> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.file(File('/' + widget.path)),
      autoPlay: true,
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: Container(
        color: Colors.black,
        // color: Colors.black12,
        height: widget.height == null ? null : widget.height,
        child: Column(
          children: [
            Spacer(),
            Container(
              // height: widget.height,

              child: FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: FlickVideoWithControls(
                  controls: FlickPortraitControls(),
                ),
                flickVideoWithControlsFullscreen: FlickVideoWithControls(
                  controls: FlickLandscapeControls(),
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    this.height,
    required this.path,
  }) : super(key: key);

  final double? height;
  final String path;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File('/' + widget.path))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize()
      ..play().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: _controller.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: VideoPlayer(_controller))
          : Padding(
              padding: const EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

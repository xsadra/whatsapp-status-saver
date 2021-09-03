import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets.dart' show CircularItem;

class VideoItem extends StatefulWidget {
  const VideoItem({Key? key, required this.uri}) : super(key: key);

  final Uri uri;

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    var path = '/' + widget.uri.path;
    _controller = VideoPlayerController.file(File(path))
      ..addListener(() => setState(() {}))
      ..initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildCircularIVideo(),
        buildPlaybackIcon(),
      ],
    );
  }

  Widget buildPlaybackIcon() {
    return Container(
      height: 45,
      width: 45,
      decoration: const BoxDecoration(
        color: const Color(0x99FFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Icon(
        Icons.play_circle_outline,
        color: Colors.blue,
        size: 40,
      ),
    );
  }

  Widget buildCircularIVideo() {
    return CircularItem(
      radius: 50,
      child: _controller.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: VideoPlayer(_controller))
          : Padding(
              padding: const EdgeInsets.all(32.0),
              child: const CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

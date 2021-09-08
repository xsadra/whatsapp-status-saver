import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets.dart' show CircularItem;

class VideoItem extends StatefulWidget {
  const VideoItem({
    Key? key,
    required this.uri,
    this.tag,
    this.radius = 50.0,
    this.iconSize = 45.0,
  }) : super(key: key);

  final Uri uri;
  final String? tag;
  final double? radius;
  final double? iconSize;

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
      height: widget.iconSize,
      width: widget.iconSize,
      decoration: BoxDecoration(
        color: const Color(0x99FFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(widget.iconSize! - 5)),
      ),
      child: Icon(
        Icons.play_circle_outline,
        color: Colors.blue,
        size: widget.iconSize! - 5,
      ),
    );
  }

  Widget buildCircularIVideo() {
    return CircularItem(
      radius: widget.radius!,
      child: _controller.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius!),
              child: Hero(
                tag: widget.tag ?? widget.uri.path,
                child: VideoPlayer(_controller),
              ),
            )
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

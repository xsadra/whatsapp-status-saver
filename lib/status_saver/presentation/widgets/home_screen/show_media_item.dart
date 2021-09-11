import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/models/media_type.dart';
import '../widgets.dart' show CircularItem, VideoItem;

class ShowMediaItem extends StatelessWidget {
  const ShowMediaItem({
    Key? key,
    required this.uri,
    this.isLongList = false,
  }) : super(key: key);

  final Uri uri;
  final bool isLongList;

  @override
  Widget build(BuildContext context) {
    var isImage = mediaTypeFromString(uri.pathSegments.last.split('.')[1])
        .isOf(MediaType.Image);

    var tag = isLongList ? uri.path + 'long' : uri.path;
    return isImage
        ? CircularItem(
            radius: 50,
            child: Hero(
              tag: tag,
              child: CircleAvatar(
                backgroundImage: FileImage(File.fromUri(uri)),
              ),
            ),
          )
        : VideoItem(uri: uri);
  }
}

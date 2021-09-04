import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/models/media_type.dart';
import '../widgets.dart' show CircularItem, VideoItem;

class ShowMediaItem extends StatelessWidget {
  const ShowMediaItem({
    Key? key,
    required this.uri,
  }) : super(key: key);

  final Uri uri;

  @override
  Widget build(BuildContext context) {
    var isImage = mediaTypeFromString(uri.pathSegments.last.split('.')[1])
        .isOf(MediaType.Image);

    return isImage
        ? CircularItem(
            radius: 50,
            child: CircleAvatar(backgroundImage: FileImage(File.fromUri(uri))),
          )
        : VideoItem(uri: uri);
  }
}

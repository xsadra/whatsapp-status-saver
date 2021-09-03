import 'package:flutter/material.dart'
    show BuildContext, Key, StatelessWidget, Widget;

import '../../../data/models/models.dart';
import '../widgets.dart' show ImageViewerWidget, VideoPlayerWidget;

class ShowMediaDetail extends StatelessWidget {
  const ShowMediaDetail({
    Key? key,
    required this.uri,
    required this.height,
  }) : super(key: key);

  final Uri uri;
  final double height;

  @override
  Widget build(BuildContext context) {
    var isImage = mediaTypeFromString(
      uri.pathSegments.last.split('.')[1],
    ).isOf(MediaType.Image);

    return isImage
        ? ImageViewerWidget(path: uri.path, height: height)
        : VideoPlayerWidget(path: uri.path, height: height);
  }
}

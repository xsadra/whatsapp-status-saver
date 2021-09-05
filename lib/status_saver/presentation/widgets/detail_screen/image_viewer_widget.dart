import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewerWidget extends StatelessWidget {
  const ImageViewerWidget({
    Key? key,
    required this.uri,
    required this.height,
  }) : super(key: key);

  final Uri uri;
  final double height;

  @override
  Widget build(BuildContext context) => Image.file(
        File.fromUri(uri),
        height: height,
      );
}

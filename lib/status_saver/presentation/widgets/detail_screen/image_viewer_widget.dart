import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewerWidget extends StatelessWidget {
  const ImageViewerWidget({
    Key? key,
    required this.path,
    required this.height,
  }) : super(key: key);

  final String path;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.file(File(path), height: height);
  }
}

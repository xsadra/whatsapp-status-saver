import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart' show kDefaultPadding;
import '../../../data/models/models.dart';
import '../widgets.dart' show CircularItem, VideoItem;

class ShortListItem extends StatelessWidget {
  const ShortListItem({
    Key? key,
    required this.uri,
    required this.tag,
  }) : super(key: key);

  final String tag;
  final Uri uri;

  @override
  Widget build(BuildContext context) {
    var isImage = mediaTypeFromString(uri.pathSegments.last.split('.')[1])
        .isOf(MediaType.Image);
    return Padding(
      padding: const EdgeInsets.only(right: kDefaultPadding / 2),
      child: Hero(
        tag: tag,
        child: isImage
            ? CircularItem(
                radius: 50,
                child:
                    CircleAvatar(backgroundImage: FileImage(File.fromUri(uri))),
              )
            : SizedBox(
                height: 50,
                width: 50,
                child: VideoItem(
                  uri: uri,
                  radius: 25,
                  iconSize: 20,
                ),
              ),
      ),
    );
  }
}

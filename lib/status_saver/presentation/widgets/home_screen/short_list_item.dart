import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart'
    show kDefaultPadding, kPanelTransition;
import '../../../data/models/models.dart';
import '../../pages/pages.dart' show DetailsScreen;
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
      child: GestureDetector(
        onTap: () {
          navigateToDetailsScreen(context);
        },
        child: isImage
            ? CircularItem(
                radius: 50,
                child: Hero(
                    tag: tag,
                    child: CircleAvatar(
                        backgroundImage: FileImage(File.fromUri(uri)))),
              )
            : SizedBox(
                height: 50,
                width: 50,
                child: VideoItem(
                  uri: uri,
                  tag: tag,
                  radius: 25,
                  iconSize: 20,
                ),
              ),
      ),
    );
  }

  Future<dynamic> navigateToDetailsScreen(BuildContext buildContext) {
    return Navigator.push(
      buildContext,
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: kPanelTransition,
        reverseTransitionDuration: kPanelTransition,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: DetailsScreen(
              uri: uri,
              tag: uri.path + 'tag',
              height: MediaQuery.of(buildContext).size.height,
              onSave: () {},
              showButtons: false,
            ),
          );
        },
      ),
    );
  }
}

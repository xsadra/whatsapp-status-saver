import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/core/constants/constants.dart';
import 'package:whatsapp_status_saver/status_saver/presentation/pages/detail_screen.dart';

import '../widgets.dart';

class StatusImage extends StatelessWidget {
  const StatusImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('onTap: ' + imagePath);
      },
      onDoubleTap: () {
        print('onDoubleTap: ' + imagePath);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.white),
        child: OpenContainer(
          closedElevation: 0,
          closedBuilder: (context, action) => CircularAvatar(
            imagePath: imagePath,
            radius: kStatusImageRadius,
            borderColor: Colors.green,
            borderWidth: 3,
          ),
          openBuilder: (context, action) => DetailScreen(imagePath: imagePath),
        ),
      ),
    );
  }
}

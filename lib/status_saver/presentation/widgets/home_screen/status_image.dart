import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../widgets.dart';

class StatusImage extends StatelessWidget {
  const StatusImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CircularAvatar(
      imagePath: imagePath,
      radius: kStatusImageRadius,
      borderColor: Colors.green,
      borderWidth: 3,
      // isOnlyText: true,
    );
  }
}

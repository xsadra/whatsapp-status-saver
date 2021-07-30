import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/size_config.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    required this.backgroundImage,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String backgroundImage;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          backgroundImage,
          height: getProportionateScreenWidth(315),
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(77)),
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(65),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 0.5,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}

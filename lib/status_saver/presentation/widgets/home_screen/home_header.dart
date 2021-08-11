import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

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
              style: GoogleFonts.zillaSlab(
                fontSize: getProportionateScreenWidth(65),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 0.5,
              ),
            ),
            VerticalSpacing(of: 6),
            Text(
              subTitle,
              style: GoogleFonts.zillaSlab(
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}

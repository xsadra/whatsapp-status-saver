import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/size_config.dart';
import '../../../../core/constants/constants.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kDefaultPadding)),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'See All',
            ),
          ),
        ],
      ),
    );
  }
}

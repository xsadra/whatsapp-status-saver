import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/size_config.dart';
import '../widgets.dart';

class StatusImageCollection extends StatelessWidget {
  const StatusImageCollection({
    Key? key,
    required this.paths,
  }) : super(key: key);

  final List<String> paths;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            paths.length > 5 ? 5 : paths.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: StatusImage(imagePath: paths.elementAt(index)),
            ),
          ),
          // Spacer(),
          if (paths.length > 5)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: StatusImage(imagePath: 'assets/images/more.webp'),
            ),
        ],
      ),
    );
  }
}

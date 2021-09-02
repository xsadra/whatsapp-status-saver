import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../controllers/home_controller.dart' show HomeController;
import '../../widgets/widgets.dart' show HomeGridViewItem;

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    Key? key,
    required this.images,
    required this.controller,
    required this.constraints,
  }) : super(key: key);

  final List<Uri> images;
  final HomeController controller;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: kDefaultPadding / 2,
        crossAxisSpacing: kDefaultPadding / 2,
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: HomeGridViewItem(
            controller: controller,
            uri: images[index],
            constraints: constraints),
      ),
    );
  }
}

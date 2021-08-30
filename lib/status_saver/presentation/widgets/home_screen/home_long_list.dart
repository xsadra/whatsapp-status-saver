import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart' show kDefaultPadding;
import '../../controllers/home_controller.dart' show HomeController;

class HomeLongList extends StatelessWidget {
  HomeLongList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kDefaultPadding * 1.5),
          bottomRight: Radius.circular(kDefaultPadding * 1.5),
          topLeft: Radius.circular(kDefaultPadding * 1.5),
          topRight: Radius.circular(kDefaultPadding * 1.5),
        ),
      ),
      child: GridView.builder(
        // scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: controller.paths.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: kDefaultPadding / 2,
          crossAxisSpacing: kDefaultPadding / 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Hero(
                tag: controller.paths[index],
                child: CircleAvatar(
                  backgroundImage:
                      FileImage(File.fromUri(controller.paths[index])),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

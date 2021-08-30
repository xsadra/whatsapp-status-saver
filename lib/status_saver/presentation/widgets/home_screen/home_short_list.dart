import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart' show kDefaultPadding;
import '../../controllers/home_controller.dart' show HomeController;

class HomeShortList extends StatelessWidget {
  const HomeShortList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Text(
            "Saved",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(width: kDefaultPadding),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  controller.paths.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding / 2),
                    child: Hero(
                      tag: controller.paths[index].path + "tag",
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            FileImage(File.fromUri(controller.paths[index])),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

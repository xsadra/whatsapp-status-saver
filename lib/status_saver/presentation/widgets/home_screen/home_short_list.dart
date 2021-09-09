import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart' show kDefaultPadding;
import '../../controllers/home_controller.dart' show HomeController;
import '../widgets.dart';

class HomeShortList extends StatelessWidget {
  const HomeShortList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    var length = controller.paths.length;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 00.0),
          child: Row(
            children: [
              Icon(
                Icons.save,
                size: 48,
                color: Colors.black54,
              ),
              const SizedBox(width: kDefaultPadding / 2),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(14),
                  child: Row(
                    children: List.generate(length, (index) {
                      var uri = controller.paths[length - index - 1];
                      var tag = uri.path + "tag";
                      return ShortListItem(uri: uri, tag: tag);
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

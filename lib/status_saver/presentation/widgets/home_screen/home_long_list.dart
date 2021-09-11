import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart'
    show kDefaultPadding, kPanelTransition;
import '../../controllers/home_controller.dart' show HomeController;
import '../../pages/pages.dart' show DetailsScreen;
import '../widgets.dart' show ShowMediaItem;

class HomeLongList extends StatelessWidget {
  HomeLongList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    var length = controller.paths.length;
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
        itemCount: length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: kDefaultPadding / 2,
          crossAxisSpacing: kDefaultPadding / 2,
        ),
        itemBuilder: (context, index) {
          var uri = controller.paths[length - index - 1];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                navigateToDetailsScreen(uri: uri, context: context);
              },
              child: Container(
                child: ShowMediaItem(uri: uri, isLongList: true),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> navigateToDetailsScreen(
      {required BuildContext context, required Uri uri}) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: kPanelTransition,
        reverseTransitionDuration: kPanelTransition,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: DetailsScreen(
              uri: uri,
              tag: uri.path + 'long',
              height: MediaQuery.of(context).size.height,
              onSave: () {},
              showButtons: false,
            ),
          );
        },
      ),
    );
  }
}

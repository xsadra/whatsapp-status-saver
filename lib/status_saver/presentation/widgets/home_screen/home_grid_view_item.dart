import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart' show kPanelTransition;
import '../../bloc/medias/bloc.dart' show MediasBloc, SaveMedia;
import '../../controllers/home_controller.dart' show HomeController;
import '../../pages/pages.dart' show DetailsScreen;
import '../widgets.dart' show ShowMediaItem;

class HomeGridViewItem extends StatelessWidget {
  const HomeGridViewItem({
    Key? key,
    required this.controller,
    required this.uri,
    required this.constraints,
  }) : super(key: key);

  final HomeController controller;
  final Uri uri;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          navigateToDetailsScreen(context);
        },
        child: Hero(
          tag: uri.path,
          child: ShowMediaItem(uri: uri),
        ),
      ),
    );
  }

  Future<dynamic> navigateToDetailsScreen(BuildContext buildContext) {
    return Navigator.push(
      buildContext,
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: kPanelTransition,
        reverseTransitionDuration: kPanelTransition,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: DetailsScreen(
              uri: uri,
              height: constraints.maxHeight * 0.90,
              onSave: () {
                controller.addToSaveList(uri);
                buildContext.read<MediasBloc>().add(SaveMedia(uri: uri));
              },
            ),
          );
        },
      ),
    );
  }
}

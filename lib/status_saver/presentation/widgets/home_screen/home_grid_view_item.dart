import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../bloc/medias/bloc.dart';
import '../../controllers/home_controller.dart' show HomeController;
import '../../pages/pages.dart' show DetailsScreen;

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
          tag: uri,
          child: CircleAvatar(
            backgroundImage: FileImage(File.fromUri(uri)),
          ),
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
              height: constraints.maxHeight * 0.90,
              onSave: () {
                controller.addToSaveList(uri);
                buildContext.read<MediasBloc>().add(SaveMedia(uri: uri));
              },
              uri: uri,
            ),
          );
        },
      ),
    );
  }
}

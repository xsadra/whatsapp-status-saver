import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart' show kDefaultPadding;

class ShortListItem extends StatelessWidget {
  const ShortListItem({
    Key? key,
    required this.uri,
    required this.tag,
  }) : super(key: key);

  final String tag;
  final Uri uri;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kDefaultPadding / 2),
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(
          color: const Color(0xFF4CAF50),
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(-5, 5)),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: const BorderRadius.all(Radius.circular(32)),
          ),
          child: Hero(
            tag: tag,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFFFFFFFF),
              backgroundImage: FileImage(File.fromUri(uri)),
            ),
          ),
        ),
      ),
    );
  }
}

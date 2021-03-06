import 'package:flutter/material.dart';

const kBgColor = Color(0xFFF6F5F2);
const primaryColor = Color(0xFF40A944);
const kPrimaryColor = Color(0xFF3E4067);
const kTextColor = Color(0xFF3F4168);
const kIconColor = Color(0xFF5E5E5E);

const kDefaultPadding = 20.0;
const kStatusImageRadius = 50.0;
const kCartBarHeight = 100.0;
const kHeaderHeight = 185.0;

final kDefaultShadow = BoxShadow(
  offset: Offset(5, 5),
  blurRadius: 10,
  color: Color(0xFFE9E9E9).withOpacity(0.56),
);

const kPanelTransition = Duration(milliseconds: 500);

class Constants {
  static const String SAVE_IMAGE_PATH =
      'storage/emulated/0/Pictures/Status Saver/';
  static const String SAVE_VIDEO_PATH =
      'storage/emulated/0/Movies/Status Saver/';
  static const String IMAGE_PATH = 'storage/emulated/0/Pictures/';
  static const String VIDEO_PATH = 'storage/emulated/0/Movies/';
  static List<Uri> savedMediaUris = [
    Uri.parse('storage/emulated/0/Pictures/Status Saver/'),
    Uri.parse('storage/emulated/0/Movies/Status Saver/'),
  ];
}

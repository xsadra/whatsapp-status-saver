import 'package:flutter/foundation.dart';

enum MediaType {
  Image,
  Video,
}

extension MediaTypeExtension on MediaType {
  String get name => describeEnum(this);

  String get value {
    switch (this) {
      case MediaType.Image:
        return 'jpg';
      case MediaType.Video:
        return 'mp4';
      default:
        return 'not found';
    }
  }
}

import 'package:flutter/foundation.dart';

enum MediaType {
  Image,
  Video,
  MotFound,
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

MediaType mediaTypeFromString(String key) => MediaType.values
    .firstWhere((v) => key == v.value, orElse: () => MediaType.MotFound);

import 'package:meta/meta.dart' show immutable;

import '../../../data/models/account_type.dart';
import '../../../data/models/media_type.dart';
import '../../../data/models/models.dart';

typedef AccountMedias = Map<AccountType, Map<MediaType, Medias>>;

@immutable
abstract class MediasState {}

class Empty extends MediasState {}

class Loading extends MediasState {}

class Saving extends MediasState {}

class Saved extends MediasState {
  final Media media;

  Saved({required this.media});
}

class Loaded extends MediasState {
  final AccountMedias accountMedias;
  final List<Uri> whatsAppVideos;
  final List<Uri> whatsAppImages;
  final List<Uri> whatsAppBusinessVideos;
  final List<Uri> whatsAppBusinessImages;

  Loaded({
    required this.whatsAppVideos,
    required this.whatsAppImages,
    required this.whatsAppBusinessVideos,
    required this.whatsAppBusinessImages,
    required this.accountMedias,
  });
}

class Error extends MediasState {
  final String message;

  Error({
    required this.message,
  });
}

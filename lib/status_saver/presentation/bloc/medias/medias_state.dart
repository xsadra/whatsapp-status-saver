import 'package:meta/meta.dart' show immutable;

import '../../../data/models/account_type.dart' show AccountType;
import '../../../data/models/models.dart' show AccountType, Media;

@immutable
abstract class MediasState {
  get state => this;
}

class Empty extends MediasState {}

class Loading extends MediasState {}

class Saving extends MediasState {}

class Saved extends MediasState {
  final Media media;

  Saved({required this.media});
}

class Loaded extends MediasState {
  final List<Uri> videos;
  final List<Uri> images;
  final AccountType accountToShow;
  final List<AccountType> accounts;

  Loaded({
    required this.videos,
    required this.images,
    required this.accountToShow,
    required this.accounts,
  });
}

class Error extends MediasState {
  final String message;

  Error({
    required this.message,
  });
}

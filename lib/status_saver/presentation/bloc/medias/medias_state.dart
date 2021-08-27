import 'package:meta/meta.dart' show immutable;

import '../../../data/models/account_type.dart';
import '../../../data/models/media_type.dart';
import '../../../data/models/medias.dart';

typedef AccountMedias = Map<AccountType, Map<MediaType, Medias>>;

@immutable
abstract class MediasState {}

class Empty extends MediasState {}

class Loading extends MediasState {}

class Loaded extends MediasState {
  final AccountMedias accountMedias;

  Loaded({
    required this.accountMedias,
  });
}

class Error extends MediasState {
  final String message;

  Error({
    required this.message,
  });
}

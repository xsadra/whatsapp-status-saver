import 'package:meta/meta.dart' show immutable;

import '../../../data/models/models.dart' show AccountType;

@immutable
abstract class MediasEvent {}

class GetAccountMedias extends MediasEvent {
  final AccountType setAccountToShow;

  GetAccountMedias({required this.setAccountToShow});
}

class SaveMedia extends MediasEvent {
  final Uri uri;

  SaveMedia({required this.uri});
}

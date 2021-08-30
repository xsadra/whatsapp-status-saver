import 'package:meta/meta.dart' show immutable;

import '../../../data/models/models.dart';

@immutable
abstract class SavedMediasState {}

class SavedMediasInitial extends SavedMediasState {}

class Empty extends SavedMediasState {}

class Loading extends SavedMediasState {}

class Deleting extends SavedMediasState {}

class Deleted extends SavedMediasState {}

class Loaded extends SavedMediasState {
  final SavedMedias savedMedias;

  Loaded({
    required this.savedMedias,
  });
}

class NoItem extends SavedMediasState {}

class Error extends SavedMediasState {
  final String message;

  Error({
    required this.message,
  });
}

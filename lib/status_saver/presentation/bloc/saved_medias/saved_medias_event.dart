import 'package:meta/meta.dart' show immutable;

import '../../../data/models/models.dart';

@immutable
abstract class SavedMediasEvent {}

class GetSavedMedias extends SavedMediasEvent {}

class DeleteMedia extends SavedMediasEvent {
  final Media media;

  DeleteMedia({required this.media});
}

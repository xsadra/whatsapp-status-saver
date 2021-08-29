import 'package:meta/meta.dart' show immutable;

@immutable
abstract class MediasEvent {}

class GetAccountMedias extends MediasEvent {}

class SaveMedia extends MediasEvent {
  final Uri uri;

  SaveMedia({required this.uri});
}

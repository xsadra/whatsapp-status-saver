import 'package:meta/meta.dart' show immutable;

@immutable
abstract class MediasEvent {}

class GetAccountMedias extends MediasEvent {}

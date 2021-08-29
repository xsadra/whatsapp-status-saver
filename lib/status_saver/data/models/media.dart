import 'models.dart';

class Media {
  final Uri uri;
  final MediaType type;

  const Media({
    required this.uri,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Media &&
          runtimeType == other.runtimeType &&
          uri == other.uri &&
          type == other.type);

  @override
  int get hashCode => uri.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'Media{' + ' uri: $uri,' + ' type: $type,' + '}';
  }

  Media copyWith({
    Uri? uri,
    MediaType? type,
  }) {
    return Media(
      uri: uri ?? this.uri,
      type: type ?? this.type,
    );
  }
}

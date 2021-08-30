import 'models.dart';

class SavedMedias {
  final List<Media>? medias;
  final bool hasItem;

  const SavedMedias({
    required this.medias,
    required this.hasItem,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedMedias &&
          runtimeType == other.runtimeType &&
          medias == other.medias &&
          hasItem == other.hasItem);

  @override
  int get hashCode => medias.hashCode ^ hasItem.hashCode;

  @override
  String toString() {
    return 'SavedMedias{' + ' medias: $medias,' + ' hasItem: $hasItem,' + '}';
  }

  SavedMedias copyWith({
    List<Media>? medias,
    bool? isLoaded,
  }) {
    return SavedMedias(
      medias: medias ?? this.medias,
      hasItem: isLoaded ?? this.hasItem,
    );
  }
}

import 'models.dart';

class SavedMedias {
  final List<Media> medias;
  final bool isLoaded;

  const SavedMedias({
    required this.medias,
    required this.isLoaded,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedMedias &&
          runtimeType == other.runtimeType &&
          medias == other.medias &&
          isLoaded == other.isLoaded);

  @override
  int get hashCode => medias.hashCode ^ isLoaded.hashCode;

  @override
  String toString() {
    return 'SavedMedias{' + ' medias: $medias,' + ' isLoaded: $isLoaded,' + '}';
  }

  SavedMedias copyWith({
    List<Media>? medias,
    bool? isLoaded,
  }) {
    return SavedMedias(
      medias: medias ?? this.medias,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}

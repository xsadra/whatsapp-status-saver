import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/repositories/medias_repository.dart';
import '../datasources/medias_data_source.dart';
import '../models/models.dart';

typedef AccountMedias = Map<AccountType, Map<MediaType, Medias>>;

class MediasRepositoryImpl implements MediasRepository {
  final MediasDataSource dataSource;

  MediasRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, AccountMedias>> getAccountMedias() {
    try {
      Map<AccountType, Medias> accountMedias = dataSource.getAccountMedias();

      AccountMedias accountMediaSeparated = {};

      for (var entry in accountMedias.entries) {
        Map<MediaType, Medias> mediaSeparated =
            _extractMediaSeparated(entry.key, entry.value);
        accountMediaSeparated[entry.key] = mediaSeparated;
      }

      return Future.value(right(accountMediaSeparated));
    } catch (e) {
      return Future.value(left(ReadWriteFailure()));
    }
  }

  @override
  Future<Either<Failure, Media>> saveMedia(Uri uri) async {
    try {
      MediaType type = mediaTypeFromString(
        uri.pathSegments.last.split('.').last,
      );
      var media = Media(uri: uri, type: type);
      var saveMedia = await dataSource.saveMedia(media);

      return right(saveMedia);
    } on FileExistsException {
      return left(FileExistsFailure());
    }
  }

  Map<MediaType, Medias> _extractMediaSeparated(AccountType key, Medias value) {
    Map<MediaType, Medias> mediaSeparated = {};
    for (var rootUri in value.uris) {
      Directory systemTempDir = Directory.fromUri(rootUri);

      List<FileSystemEntity> listSync = systemTempDir
          .listSync(recursive: true, followLinks: true)
          .where((event) => event.path.contains('Media/.Statuses/'))
          .toList();

      for (FileSystemEntity entity in listSync) {
        Uri uri = entity.uri;
        if (uri.path.endsWith(MediaType.Image.value)) {
          Medias media = mediaSeparated[MediaType.Image] ?? Medias(uris: []);
          media.uris.add(uri);
          mediaSeparated[MediaType.Image] = media;
        } else if (uri.path.endsWith(MediaType.Video.value)) {
          Medias media = mediaSeparated[MediaType.Video] ?? Medias(uris: []);
          media.uris.add(uri);
          mediaSeparated[MediaType.Video] = media;
        } else {
          print('not supported Uri in:' + key.value + ' -> ' + uri.toString());
        }
      }
    }
    return mediaSeparated;
  }
}

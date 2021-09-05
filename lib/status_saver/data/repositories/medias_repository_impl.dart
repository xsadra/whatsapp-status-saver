import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/repositories/medias_repository.dart';
import '../datasources/medias_data_source.dart';
import '../models/models.dart';

typedef AccountMedias = Map<AccountType, List<Media>>;

class MediasRepositoryImpl implements MediasRepository {
  final MediasDataSource dataSource;

  MediasRepositoryImpl({required this.dataSource});

  @override
  Either<Failure, AccountMedias> getAccountMedias() {
    try {
      Map<AccountType, List<Media>> accountMedias =
          dataSource.getAccountMedias();
      AccountMedias accountMediaSeparated = {};

      for (var entry in accountMedias.entries) {
        List<Media> mediaSeparated = _extractMediaSeparated(entry.value);
        accountMediaSeparated[entry.key] = mediaSeparated;
      }

      return right(accountMediaSeparated);
    } catch (e) {
      return left(ReadWriteFailure());
    }
  }

  @override
  Either<Failure, Media> saveMedia(Uri uri) {
    try {
      MediaType type = mediaTypeFromString(
        uri.pathSegments.last.split('.').last,
      );
      Media media = Media(uri: uri, type: type);
      Media saveMedia = dataSource.saveMedia(media);

      return right(saveMedia);
    } on FileExistsException {
      return left(FileExistsFailure());
    }
  }

  List<Media> _extractMediaSeparated(List<Media> value) {
    List<Media> medias = [];
    for (Media rootUri in value) {
      List<FileSystemEntity> allStatusFileSystems =
          Directory.fromUri(rootUri.uri)
              .listSync(recursive: true, followLinks: true)
              .where((event) => event.path.contains('Media/.Statuses/'))
              .toList();

      for (FileSystemEntity fileSystem in allStatusFileSystems) {
        Uri uri = fileSystem.uri;
        MediaType type = mediaTypeFromString(
          uri.pathSegments.last.split('.')[1],
        );

        if (type.isValid()) {
          medias.add(
            Media(uri: uri, type: type),
          );
        } else {
          print('-- not supported Uri at: ' + uri.toString());
        }
      }
    }
    return medias;
  }

  @override
  Either<Failure, Media> deleteMedia(Uri uri) {
    // TODO: implement deleteMedia
    throw UnimplementedError();
  }

  @override
  Either<Failure, SavedMedias> getSavedMedias() {
    try {
      SavedMedias savedMedias = dataSource.getSavedMedias();

      return right(savedMedias);
    } catch (e) {
      return left(ReadWriteFailure());
    }
  }
}

import 'dart:io';

import '../../../core/constants/constants.dart';
import '../../../core/error/exceptions.dart';
import '../models/models.dart';

abstract class MediasDataSource {
  Map<AccountType, Medias> getAccountMedias();

  Media saveMedia(Media media);

  SavedMedias getSavedMedias();

  bool? hasData(AccountType type);
}

class MediasDataSourceImpl implements MediasDataSource {
  Map<AccountType, bool> _accountHasData = {};

  List<Uri> _getStorages() {
    //Todo: get available storages and return their Uris
    return [
      Uri.parse('storage/emulated/0'),
      Uri.parse('storage/emulated/1'),
    ];
  }

  @override
  Map<AccountType, Medias> getAccountMedias() {
    Map<AccountType, Medias> accountMedias = {};

    List<Uri> storages = _getStorages()
        .where((storage) => Directory.fromUri(storage).existsSync())
        .toList(growable: false);

    List<FileSystemEntity> fileSystemEntities = [
      for (Uri storageUri in storages)
        ...Directory.fromUri(storageUri).listSync()
    ];

    for (AccountType type in AccountType.values) {
      for (FileSystemEntity entity in fileSystemEntities) {
        if (entity.path.endsWith(type.value)) {
          Medias accountMedia = accountMedias[type] ?? Medias(uris: []);
          accountMedia.uris.add(entity.uri);
          accountMedias[type] = accountMedia;
          _accountHasData[type] = true;
        }
      }
    }

    return accountMedias;
  }

  @override
  Media saveMedia(Media media) {
    Uri statusMediaUri = media.uri;
    String statusMediaFileName = statusMediaUri.pathSegments.last;
    String toSaveStatusMediaPath = media.type.isOf(MediaType.Image)
        ? Constants.SAVE_IMAGE_PATH
        : Constants.SAVE_VIDEO_PATH;

    String toSaveStatusMediaPathWithExtension =
        toSaveStatusMediaPath + statusMediaFileName;

    Uri toSaveStatusMediaUri = Uri.parse(toSaveStatusMediaPathWithExtension);

    Directory toSaveStatusMediaDir = Directory.fromUri(toSaveStatusMediaUri);
    if (toSaveStatusMediaDir.existsSync()) {
      throw FileExistsException();
    }

    _createFolder(media.type, toSaveStatusMediaPath);
    File statusMediaFile = File.fromUri(statusMediaUri);
    File savedStatusFile =
        statusMediaFile.copySync(toSaveStatusMediaPathWithExtension);

    return media.copyWith(uri: savedStatusFile.uri);
  }

  @override
  bool? hasData(AccountType type) {
    return _accountHasData[type];
  }

  void _createFolder(MediaType type, String toSavePath) {
    Directory(toSavePath).createSync(recursive: true);

    Directory folderDirSavePath = Directory.fromUri(Uri.parse(toSavePath));

    if (!folderDirSavePath.existsSync()) {
      folderDirSavePath.createSync(recursive: true);
    }
  }

  @override
  SavedMedias getSavedMedias() {
    List<Uri> storages = Constants.savedMediaUris
        .where((storage) => Directory.fromUri(storage).existsSync())
        .toList(growable: false);

    List<FileSystemEntity> savedMediaEntities = [
      for (Uri uri in storages) ...Directory.fromUri(uri).listSync()
    ];

    List<Media> savedMedias = savedMediaEntities.map((e) {
      return Media(
          uri: e.uri,
          type: mediaTypeFromString(
            e.uri.pathSegments.last.split('.').last,
          ));
    }).toList();
    return SavedMedias(medias: savedMedias, hasItem: savedMedias.length > 0);
  }
}

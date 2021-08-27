import 'dart:io';

import '../../../core/constants/constants.dart';
import '../../../core/error/exceptions.dart';
import '../models/models.dart';

abstract class MediasDataSource {
  Map<AccountType, Medias> getAccountMedias();

  Media saveMedia(Media media);

  bool? hasData(AccountType type);
}

class MediasDataSourceImpl implements MediasDataSource {
  Map<AccountType, bool> _accountHasData = {};

  List<Uri> _getStorages() {
    //Todo: get available storages and return their Uris
    return [
      // Uri.parse('storage/emulated/0'),
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
      for (var storage in storages) ...Directory.fromUri(storage).listSync()
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
    String toSaveStatusMediaPath = media.type == MediaType.Image
        ? Constants.SAVE_IMAGE_PATH + statusMediaFileName
        : Constants.SAVE_VIDEO_PATH + statusMediaFileName;

    Uri toSaveStatusMediaUri = Uri.parse(toSaveStatusMediaPath);
    File toSaveStatusMediaFile = File.fromUri(toSaveStatusMediaUri);

    if (toSaveStatusMediaFile.existsSync()) {
      throw FileExistsException();
    }

    _createFolder(media.type);
    File statusMediaFile = File.fromUri(statusMediaUri);
    File savedStatusFile = statusMediaFile.copySync(toSaveStatusMediaPath);

    return media.copyWith(uri: savedStatusFile.uri);
  }

  @override
  bool? hasData(AccountType type) {
    return _accountHasData[type];
  }

  void _createFolder(MediaType type) {
    String folderPath =
        type == MediaType.Image ? Constants.IMAGE_PATH : Constants.VIDEO_PATH;

    File folder = File.fromUri(Uri.parse(folderPath));
    if (!folder.existsSync()) {
      folder.createSync();
    }
  }
}

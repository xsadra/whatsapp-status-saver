import 'dart:developer';
import 'dart:io';

import '../../../core/constants/constants.dart';
import '../../../core/error/exceptions.dart';
import '../models/models.dart';

abstract class MediasDataSource {
  Map<AccountType, Medias> getAccountMedias();

  Future<Media> saveMedia(Media media);

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
  Future<Media> saveMedia(Media media) async {
    Uri statusMediaUri = media.uri;
    String statusMediaFileName = statusMediaUri.pathSegments.last;
    String toSaveStatusMediaPath = media.type == MediaType.Image
        ? Constants.SAVE_IMAGE_PATH
        : Constants.SAVE_VIDEO_PATH;

    String toSaveStatusMediaPathWithExtension =
        toSaveStatusMediaPath + statusMediaFileName;

    Uri toSaveStatusMediaUri = Uri.parse(toSaveStatusMediaPathWithExtension);

    log(toSaveStatusMediaUri.toString(), name: 'MediasDataSourceImpl');

    Directory toSaveStatusMediaDir = Directory.fromUri(toSaveStatusMediaUri);
    if (toSaveStatusMediaDir.existsSync()) {
      throw FileExistsException();
    }

    await _createFolder(media.type, toSaveStatusMediaPath);
    File statusMediaFile = File.fromUri(statusMediaUri);
    File savedStatusFile =
        statusMediaFile.copySync(toSaveStatusMediaPathWithExtension);

    return media.copyWith(uri: savedStatusFile.uri);
  }

  @override
  bool? hasData(AccountType type) {
    return _accountHasData[type];
  }

  Future<void> _createFolder(MediaType type, String toSavePath) async {
    Directory(toSavePath).createSync(recursive: true);

    Directory folderDirSavePath = Directory.fromUri(Uri.parse(toSavePath));

    if (!folderDirSavePath.existsSync()) {
      folderDirSavePath.createSync(recursive: true);
    }
  }
}

import 'dart:io';

import '../models/account_type.dart';
import '../models/medias.dart';

abstract class MediasDataSource {
  Map<AccountType, Medias> getAccountMedias();

  bool? hasData(AccountType type);
}

class MediasDataSourceImpl implements MediasDataSource {
  Map<AccountType, bool> _accountHasData = {};

  List<Uri> _getStorages() {
    //Todo: get available storages and return their Uris
    return [
      Uri.parse('storage/emulated/0'),
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
  bool? hasData(AccountType type) {
    return _accountHasData[type];
  }
}

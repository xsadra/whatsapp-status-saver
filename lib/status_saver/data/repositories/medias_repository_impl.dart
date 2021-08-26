import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/account_type.dart';
import '../../data/models/medias.dart';
import '../../domain/repositories/medias_repository.dart';
import '../datasources/medias_data_source.dart';
import '../models/media_type.dart';

typedef AccountMedias = Map<AccountType, Map<MediaType, Medias>>;

class MediasRepositoryImpl implements MediasRepository {
  final MediasDataSource dataSource;

  MediasRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, AccountMedias>> getAccountMedias() {
    try {
      Map<AccountType, Medias> accountMedias = dataSource.getAccountMedias();

      AccountMedias accountMediaSeparated = {};
      accountMedias.forEach((key, value) {
        Map<MediaType, Medias> mediaSeparated = {};
        for (var uri in value.uris) {
          if (uri.path.endsWith(MediaType.Image.value)) {
            Medias media = mediaSeparated[MediaType.Image] ?? Medias(uris: []);
            media.uris.add(uri);
            mediaSeparated[MediaType.Image] = media;
          } else if (uri.path.endsWith(MediaType.Video.value)) {
            Medias media = mediaSeparated[MediaType.Video] ?? Medias(uris: []);
            media.uris.add(uri);
            mediaSeparated[MediaType.Video] = media;
          }
        }
        accountMediaSeparated[key] = mediaSeparated;
      });

      return Future.value(right(accountMediaSeparated));
    } catch (e) {
      return Future.value(left(ReadWriteException()));
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/models.dart';

abstract class MediasRepository {
  Future<Either<Failure, Map<AccountType, Map<MediaType, Medias>>>>
      getAccountMedias();

  Future<Either<Failure, Media>> saveMedia(Uri uri);
}

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/models.dart';

abstract class MediasRepository {
  Either<Failure, Map<AccountType, Map<MediaType, Medias>>> getAccountMedias();

  Either<Failure, Media> saveMedia(Uri uri);
}

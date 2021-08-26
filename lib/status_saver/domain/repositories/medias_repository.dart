import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/account_type.dart';
import '../../data/models/media_type.dart';
import '../../data/models/medias.dart';

abstract class MediasRepository {
  Future<Either<Failure, Map<AccountType, Map<MediaType, Medias>>>>
      getAccountMedias();
}

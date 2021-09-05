import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/models.dart';

typedef AccountMedias = Map<AccountType, List<Media>>;

abstract class MediasRepository {
  Either<Failure, AccountMedias> getAccountMedias();

  Either<Failure, Media> saveMedia(Uri uri);

  Either<Failure, Media> deleteMedia(Uri uri);

  Either<Failure, SavedMedias> getSavedMedias();
}

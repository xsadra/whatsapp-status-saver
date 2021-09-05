import 'package:bloc/bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../data/models/models.dart';
import '../../../domain/repositories/medias_repository.dart';
import 'bloc.dart';

class MediasBloc extends Bloc<MediasEvent, MediasState> {
  final MediasRepository _repository;

  MediasBloc({required MediasRepository repository})
      : _repository = repository,
        super(Empty());

  @override
  Stream<MediasState> mapEventToState(
    MediasEvent event,
  ) async* {
    if (event is GetAccountMedias) {
      yield Loading();
      final failureOrAccountMedias = _repository.getAccountMedias();
      final accountType = event.setAccountToShow;

      yield failureOrAccountMedias.fold(
        (failure) => Error(message: failure.toMessage),
        (accountMedias) {
          var accounts = accountMedias.keys.toList();
          accounts.sort((a, b) => a.index - b.index);

          return Loaded(
            images: _getUrisByType(
              medias: accountMedias[accountType]!,
              type: MediaType.Image,
            ),
            videos: _getUrisByType(
              medias: accountMedias[accountType]!,
              type: MediaType.Video,
            ),
            accountToShow: accountType,
            accounts: accounts,
          );
        },
      );
    } else if (event is SaveMedia) {
      yield Saving();
      final failureOrMedia = _repository.saveMedia(event.uri);

      yield failureOrMedia.fold(
        (failure) => Error(message: failure.toMessage),
        (media) => Saved(media: media),
      );
    } else {
      yield Error(message: 'Unexpected Event');
    }
  }

  List<Uri> _getUrisByType({
    required List<Media> medias,
    required MediaType type,
  }) =>
      medias
          .where((media) => media.type == type)
          .map((media) => media.uri)
          .toList();
}

import 'package:bloc/bloc.dart';
import 'package:whatsapp_status_saver/status_saver/data/models/account_type.dart';
import 'package:whatsapp_status_saver/status_saver/data/models/media_type.dart';
import 'package:whatsapp_status_saver/status_saver/data/models/medias.dart';

import '../../../../core/error/failure.dart';
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
      final failureOrAccountMedias = await _repository.getAccountMedias();

      yield failureOrAccountMedias.fold(
        (failure) => Error(message: failure.toMessage),
        (accountMedias) {
          return Loaded(
            accountMedias: accountMedias,
            whatsAppBusinessVideos: _getExpandedUris(
                accountMedias: accountMedias,
                accountType: AccountType.WhatsAppBusiness,
                mediaType: MediaType.Video),
            whatsAppBusinessImages: _getExpandedUris(
                accountMedias: accountMedias,
                accountType: AccountType.WhatsAppBusiness,
                mediaType: MediaType.Image),
            whatsAppImages: _getExpandedUris(
                accountMedias: accountMedias,
                accountType: AccountType.WhatsApp,
                mediaType: MediaType.Image),
            whatsAppVideos: _getExpandedUris(
                accountMedias: accountMedias,
                accountType: AccountType.WhatsApp,
                mediaType: MediaType.Video),
          );
        },
      );
    } else if (event is SaveMedia) {
      yield Saving();
      final failureOrMedia = await _repository.saveMedia(event.uri);

      yield failureOrMedia.fold(
        (failure) => Error(message: failure.toMessage),
        (media) => Saved(media: media),
      );
    } else {
      yield Error(message: 'Unexpected Event');
    }
  }

  List<Uri> _getExpandedUris(
      {required Map<AccountType, Map<MediaType, Medias>> accountMedias,
      required AccountType accountType,
      required MediaType mediaType}) {
    return accountMedias[accountType]
            ?.entries
            .where((element) => element.key == mediaType)
            .map((e) => e.value)
            .toList()
            .expand((element) => element.uris)
            .toList() ??
        [];
  }
}

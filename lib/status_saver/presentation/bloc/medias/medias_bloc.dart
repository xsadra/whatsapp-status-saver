import 'dart:async';

import 'package:bloc/bloc.dart';

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
        (accountMedias) => Loaded(accountMedias: accountMedias),
      );
    } else {
      yield Error(message: 'Unexpected Event');
    }
  }
}

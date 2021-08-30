import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/repositories/medias_repository.dart';
import 'bloc.dart';

class SavedMediasBloc extends Bloc<SavedMediasEvent, SavedMediasState> {
  final MediasRepository _repository;

  SavedMediasBloc({required MediasRepository repository})
      : _repository = repository,
        super(Empty());

  @override
  Stream<SavedMediasState> mapEventToState(
    SavedMediasEvent event,
  ) async* {
    if (event is GetSavedMedias) {
      yield Loading();
      final failureOrSavedMedias = _repository.getSavedMedias();

      yield failureOrSavedMedias
          .fold((failure) => Error(message: failure.toMessage), (savedMedias) {
        if (savedMedias.hasItem) {
          return Loaded(savedMedias: savedMedias);
        }
        return NoItem();
      });
    }
  }
}

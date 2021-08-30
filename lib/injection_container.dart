import 'package:get_it/get_it.dart' show GetIt;

import 'status_saver/data/datasources/medias_data_source.dart';
import 'status_saver/data/repositories/medias_repository_impl.dart';
import 'status_saver/domain/repositories/medias_repository.dart';
import 'status_saver/presentation/bloc/medias/bloc.dart';
import 'status_saver/presentation/bloc/saved_medias/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => MediasBloc(repository: sl()),
  );
  sl.registerFactory(
    () => SavedMediasBloc(repository: sl()),
  );

  sl.registerLazySingleton<MediasRepository>(
    () => MediasRepositoryImpl(
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<MediasDataSource>(
    () => MediasDataSourceImpl(),
  );
}

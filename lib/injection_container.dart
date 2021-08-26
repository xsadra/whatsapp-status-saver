import 'package:get_it/get_it.dart' show GetIt;

import 'status_saver/data/datasources/medias_data_source.dart';
import 'status_saver/data/repositories/medias_repository_impl.dart';
import 'status_saver/domain/repositories/medias_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
// sl.registerFactory(
//       () => MediaBloc(media: sl()),
// );

  sl.registerLazySingleton<MediasRepository>(
    () => MediasRepositoryImpl(
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<MediasDataSource>(
    () => MediasDataSourceImpl(),
  );
}

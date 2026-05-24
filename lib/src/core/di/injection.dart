import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisine_explorer_local_datasource.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisines_explorer_remote_datasource.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/repository/cuisine_explorer_repository.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../network/dio_client.dart';
import '../network/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton(() => DioClient());

  getIt.registerLazySingleton(() => ApiClient(getIt<DioClient>().dio));

  getIt.registerLazySingleton<Box>(() => Hive.box('recent_cities'));

  getIt.registerLazySingleton(() => CuisineExplorerLocalDatasource(getIt()));

  getIt.registerLazySingleton(() => CuisineExplorerRemoteDatasource(getIt()));

  getIt.registerLazySingleton(
    () => CuisineExplorerRepository(getIt(), getIt()),
  );

  getIt.registerFactory(() => CuisineExplorerCubit(getIt()));
}

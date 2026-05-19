import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisines_explorer_remote_datasource.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../network/api_client.dart';



final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton(() => DioClient());

  getIt.registerLazySingleton(
    () => ApiClient(getIt<DioClient>().dio),
  );

  getIt.registerLazySingleton(
    () => CuisineExplorerRemoteDatasource(getIt()),
  );

  getIt.registerFactory(
    () => CuisineExplorerCubit(getIt()),
  );
}
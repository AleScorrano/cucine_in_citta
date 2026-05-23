import 'package:cucine_in_citta/src/core/network/api_client.dart';
import 'package:cucine_in_citta/src/core/network/dio_client.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisines_explorer_remote_datasource.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/viewModels/cuisine_explorer_state.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/viewModels/cuisine_explorer_viewModel.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final apiClinetProvider = Provider<ApiClient>((ref) {
  final dioClient = ref.read(dioProvider);
  return ApiClient(dioClient.dio);
});

final cuisineExplorerDataSourceProvider =
    Provider<CuisineExplorerRemoteDatasource>((ref) {
      final apiClinet = ref.read(apiClinetProvider);
      return CuisineExplorerRemoteDatasource(apiClinet);
    });

final cuisineExplorerViewModelProvider =
    NotifierProvider<CuisineExplorerViewModel, CuisineExplorerState>(
      CuisineExplorerViewModel.new,
    );

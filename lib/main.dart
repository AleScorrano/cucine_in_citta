import 'package:cucine_in_citta/src/core/di/injection.dart';
import 'package:cucine_in_citta/src/core/theme/app_theme.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/cuisines_explorer_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final home = BlocProvider(
      create: (_) => getIt<CuisineExplorerCubit>(),
      child: CuisineExplorerPage(),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Cucine in città',

      theme: AppTheme.dark,

      home: kIsWeb
          ? Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: home,
              ),
            )
          : home,
    );
  }
}

import 'package:cucine_in_citta/src/core/theme/app_theme.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/cuisines_explorer_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await setupDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final home = CuisineExplorerPage();

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

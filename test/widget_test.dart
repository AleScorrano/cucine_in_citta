import 'package:cucine_in_citta/src/features/cuisines_explorer/data/repository/cuisine_explorer_repository.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/cuisines_explorer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCuisineExplorerRepository extends Mock
    implements CuisineExplorerRepository {}

void main() {
  late MockCuisineExplorerRepository repository;

  setUp(() {
    repository = MockCuisineExplorerRepository();
    when(() => repository.getRecentCities()).thenReturn([]);
  });

  Future<void> pumpCuisineExplorer(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => CuisineExplorerCubit(repository),
          child: const CuisineExplorerPage(),
        ),
      ),
    );
  }

  testWidgets('shows the city search screen when idle', (tester) async {
    await pumpCuisineExplorer(tester);

    expect(find.text('Cucine in città'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    final searchField = tester.widget<TextField>(find.byType(TextField));
    expect(searchField.decoration?.hintText, 'Cerca una città...');
  });
}

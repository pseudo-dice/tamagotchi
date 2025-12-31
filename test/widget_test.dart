// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:pocketpet/src/app.dart';
import 'package:pocketpet/src/services/pet_storage.dart';
import 'package:pocketpet/src/state/pet_state.dart';
import 'package:pocketpet/src/state/theme_state.dart';

void main() {
  testWidgets('PocketPet app renders start screen',
      (WidgetTester tester) async {
    final petState = PetState(storage: _FakePetStorage());
    addTearDown(petState.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<PetState>.value(value: petState),
          ChangeNotifierProvider<ThemeState>(create: (_) => ThemeState()),
        ],
        child: const PocketPetApp(),
      ),
    );

    expect(find.textContaining('PocketPet'), findsWidgets);
  });
}

class _FakePetStorage extends PetStorage {
  @override
  Future<PetSnapshot?> load() async => null;

  @override
  Future<void> save(PetSnapshot snapshot) async {}

  @override
  Future<void> clear() async {}
}

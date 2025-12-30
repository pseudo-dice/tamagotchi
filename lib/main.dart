import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/services/pet_storage.dart';
import 'src/state/pet_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = PetStorage();
  final petState = PetState(storage: storage);
  await petState.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PetState>.value(value: petState),
      ],
      child: const TamagotchiApp(),
    ),
  );
}

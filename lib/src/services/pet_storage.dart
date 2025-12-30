import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../state/pet_state.dart';

class PetStorage {
  static const _storageKey = 'tamagotchi_pet_state';

  Future<PetSnapshot?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) {
      return null;
    }

    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      return PetSnapshot(
        hunger: (data['hunger'] as num?)?.toInt() ?? PetState.initialStat,
        energy: (data['energy'] as num?)?.toInt() ?? PetState.initialStat,
        happiness: (data['happiness'] as num?)?.toInt() ?? PetState.initialStat,
        lastUpdated: DateTime.tryParse(data['lastUpdated'] as String? ?? '') ??
            DateTime.now().toUtc(),
      );
    } on FormatException {
      return null;
    }
  }

  Future<void> save(PetSnapshot snapshot) async {
    final prefs = await SharedPreferences.getInstance();
    final payload = jsonEncode(<String, dynamic>{
      'hunger': snapshot.hunger,
      'energy': snapshot.energy,
      'happiness': snapshot.happiness,
      'lastUpdated': snapshot.lastUpdated.toUtc().toIso8601String(),
    });
    await prefs.setString(_storageKey, payload);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../services/pet_storage.dart';

class PetState extends ChangeNotifier {
  PetState({required this.storage});

  static const maxStat = 100;
  static const minStat = 0;
  static const initialStat = 70;

  static const _hungerDecayPerHour = 8;
  static const _energyDecayPerHour = 6;
  static const _happinessDecayPerHour = 7;

  final PetStorage storage;

  int hunger = initialStat;
  int energy = initialStat;
  int happiness = initialStat;
  DateTime lastUpdated = DateTime.now().toUtc();

  Timer? _timer;

  double get hungerPercent => hunger / maxStat;
  double get energyPercent => energy / maxStat;
  double get happinessPercent => happiness / maxStat;

  String get mood {
    final average = (hunger + energy + happiness) / 3;
    if (average >= 80) {
      return 'Ecstatic';
    }
    if (average >= 60) {
      return 'Content';
    }
    if (average >= 40) {
      return 'Restless';
    }
    return 'Needs Attention';
  }

  bool get isCritical => hunger < 30 || energy < 30 || happiness < 30;

  Future<void> initialize() async {
    final snapshot = await storage.load();
    if (snapshot != null) {
      hunger = snapshot.hunger;
      energy = snapshot.energy;
      happiness = snapshot.happiness;
      lastUpdated = snapshot.lastUpdated;
    }

    _applyTimeDecay();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _tick());
    notifyListeners();
  }

  void feed() {
    hunger = _clamp(hunger + 25);
    happiness = _clamp(happiness + 5);
    _markInteraction();
  }

  void play() {
    happiness = _clamp(happiness + 22);
    energy = _clamp(energy - 12);
    hunger = _clamp(hunger - 6);
    _markInteraction();
  }

  void rest() {
    energy = _clamp(energy + 28);
    hunger = _clamp(hunger - 4);
    _markInteraction();
  }

  Future<void> reset() async {
    hunger = initialStat;
    energy = initialStat;
    happiness = initialStat;
    lastUpdated = DateTime.now().toUtc();
    await storage.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick() {
    _applyTimeDecay();
    notifyListeners();
  }

  void _applyTimeDecay() {
    final now = DateTime.now().toUtc();
    final secondsElapsed = now.difference(lastUpdated).inSeconds;
    if (secondsElapsed <= 0) {
      return;
    }

    final hours = secondsElapsed / 3600;
    final hungerDrop = (_hungerDecayPerHour * hours).round();
    final energyDrop = (_energyDecayPerHour * hours).round();
    final happinessDrop = (_happinessDecayPerHour * hours).round();

    final newHunger = _clamp(hunger - hungerDrop);
    final newEnergy = _clamp(energy - energyDrop);
    final newHappiness = _clamp(happiness - happinessDrop);

    final didChange =
        newHunger != hunger || newEnergy != energy || newHappiness != happiness;
    hunger = newHunger;
    energy = newEnergy;
    happiness = newHappiness;
    lastUpdated = now;

    if (didChange) {
      _persist();
    }
  }

  void _markInteraction() {
    lastUpdated = DateTime.now().toUtc();
    _persist();
    notifyListeners();
  }

  void _persist() {
    unawaited(
      storage.save(
        PetSnapshot(
          hunger: hunger,
          energy: energy,
          happiness: happiness,
          lastUpdated: lastUpdated,
        ),
      ),
    );
  }

  static int _clamp(int value) => max(minStat, min(value, maxStat));
}

class PetSnapshot {
  const PetSnapshot({
    required this.hunger,
    required this.energy,
    required this.happiness,
    required this.lastUpdated,
  });

  final int hunger;
  final int energy;
  final int happiness;
  final DateTime lastUpdated;
}

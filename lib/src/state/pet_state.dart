import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../services/pet_storage.dart';

enum PetShellStyle { oceanWave, candyPop, midnightStorm }

extension PetShellStyleX on PetShellStyle {
  String get label {
    switch (this) {
      case PetShellStyle.oceanWave:
        return 'Ocean Wave';
      case PetShellStyle.candyPop:
        return 'Candy Pop';
      case PetShellStyle.midnightStorm:
        return 'Midnight Storm';
    }
  }
}

enum PetCharacter { pixelPup, roboSprout, cosmicBuddy }

enum PetAnimationType { feed, play, rest }

extension PetCharacterX on PetCharacter {
  String get label {
    switch (this) {
      case PetCharacter.pixelPup:
        return 'Pixel Pup';
      case PetCharacter.roboSprout:
        return 'Robo Sprout';
      case PetCharacter.cosmicBuddy:
        return 'Cosmic Buddy';
    }
  }
}

class PetState extends ChangeNotifier {
  PetState({required this.storage});

  static const maxStat = 100;
  static const minStat = 0;
  static const initialStat = 70;
  static const defaultShellStyle = PetShellStyle.oceanWave;
  static const defaultCharacter = PetCharacter.pixelPup;

  static const _decayInterval = Duration(minutes: 10);
  static const _decayAmount = 1;
  static const _actionCooldown = Duration(seconds: 30);
  static const _statBuffer = 10;

  final PetStorage storage;

  int hunger = initialStat;
  int energy = initialStat;
  int happiness = initialStat;
  DateTime lastUpdated = DateTime.now().toUtc();
  PetShellStyle shellStyle = defaultShellStyle;
  PetCharacter character = defaultCharacter;

  Timer? _timer;
  Timer? _cooldownTimer;
  Timer? _animationTimer;
  DateTime _lastFeedAction = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _lastPlayAction = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _lastRestAction = DateTime.fromMillisecondsSinceEpoch(0);

  PetAnimationType? currentAnimation;

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

  bool get canFeed => hunger < 90 && _isActionReady(_lastFeedAction);
  bool get canPlay =>
      energy >= 20 &&
      hunger >= 20 &&
      happiness <= maxStat - (_statBuffer - 2) &&
      _isActionReady(_lastPlayAction);
  bool get canRest => energy < 90 && _isActionReady(_lastRestAction);

  Future<void> initialize() async {
    final snapshot = await storage.load();
    if (snapshot != null) {
      hunger = snapshot.hunger;
      energy = snapshot.energy;
      happiness = snapshot.happiness;
      lastUpdated = snapshot.lastUpdated;
      shellStyle = snapshot.shellStyle;
      character = snapshot.character;
    }

    final readyTime = DateTime.now().toUtc().subtract(_actionCooldown);
    _lastFeedAction = readyTime;
    _lastPlayAction = readyTime;
    _lastRestAction = readyTime;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _tick());
    _scheduleCooldownCheck();
    currentAnimation = null;
    notifyListeners();
  }

  void feed() {
    if (!canFeed) {
      return;
    }
    hunger = _clamp(hunger + 2);
    happiness = _clamp(happiness + 2);
    _lastFeedAction = DateTime.now().toUtc();
    _markInteraction(animation: PetAnimationType.feed);
  }

  void play() {
    if (!canPlay) {
      return;
    }
    happiness = _clamp(happiness + 2);
    energy = _clamp(energy - 2);
    hunger = _clamp(hunger - 2);
    _lastPlayAction = DateTime.now().toUtc();
    _markInteraction(animation: PetAnimationType.play);
  }

  void rest() {
    if (!canRest) {
      return;
    }
    energy = _clamp(energy + 2);
    hunger = _clamp(hunger - 1);
    _lastRestAction = DateTime.now().toUtc();
    _markInteraction(animation: PetAnimationType.rest);
  }

  Future<void> reset() async {
    hunger = initialStat;
    energy = initialStat;
    happiness = initialStat;
    lastUpdated = DateTime.now().toUtc();
    shellStyle = defaultShellStyle;
    character = defaultCharacter;
    final readyTime = DateTime.now().toUtc().subtract(_actionCooldown);
    _lastFeedAction = readyTime;
    _lastPlayAction = readyTime;
    _lastRestAction = readyTime;
    currentAnimation = null;
    await storage.clear();
    _scheduleCooldownCheck();
    notifyListeners();
  }

  void selectShell(PetShellStyle style) {
    if (shellStyle == style) {
      return;
    }
    shellStyle = style;
    _persist();
    notifyListeners();
  }

  void selectCharacter(PetCharacter nextCharacter) {
    if (character == nextCharacter) {
      return;
    }
    character = nextCharacter;
    _persist();
    notifyListeners();
  }

  bool _isActionReady(DateTime lastAction) {
    return DateTime.now().toUtc().difference(lastAction) >= _actionCooldown;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cooldownTimer?.cancel();
    _animationTimer?.cancel();
    super.dispose();
  }

  void _tick() {
    final now = DateTime.now().toUtc();
    final minutesElapsed = now.difference(lastUpdated).inMinutes;
    if (minutesElapsed <= 0) {
      return;
    }

    final steps = minutesElapsed ~/ _decayInterval.inMinutes;
    final wasFeedReady = canFeed;
    final wasPlayReady = canPlay;
    final wasRestReady = canRest;

    if (steps > 0) {
      hunger = _clamp(hunger - steps * _decayAmount);
      energy = _clamp(energy - steps * _decayAmount);
      happiness = _clamp(happiness - steps * _decayAmount);
      lastUpdated = now;
      _persist();
    }

    final readinessChanged = wasFeedReady != canFeed ||
        wasPlayReady != canPlay ||
        wasRestReady != canRest;
    if (steps > 0 || readinessChanged) {
      notifyListeners();
    }

    if (readinessChanged) {
      _scheduleCooldownCheck();
    }
  }

  void _markInteraction({PetAnimationType? animation}) {
    lastUpdated = DateTime.now().toUtc();
    _persist();
    if (animation != null) {
      _startAnimation(animation);
    } else {
      notifyListeners();
    }
    _scheduleCooldownCheck();
  }

  void _startAnimation(PetAnimationType type) {
    final changed = currentAnimation != type;
    currentAnimation = type;
    _animationTimer?.cancel();
    _animationTimer = Timer(const Duration(milliseconds: 1500), () {
      _animationTimer = null;
      if (currentAnimation != null) {
        currentAnimation = null;
        notifyListeners();
      }
    });
    if (changed) {
      notifyListeners();
    } else {
      // Ensure stat updates propagate even if the animation type repeats.
      notifyListeners();
    }
  }

  void _persist() {
    unawaited(
      storage.save(
        PetSnapshot(
          hunger: hunger,
          energy: energy,
          happiness: happiness,
          lastUpdated: lastUpdated,
          shellStyle: shellStyle,
          character: character,
        ),
      ),
    );
  }

  void _scheduleCooldownCheck() {
    _cooldownTimer?.cancel();

    final now = DateTime.now().toUtc();
    DateTime? nextReady;

    void consider(DateTime readyAt) {
      if (!readyAt.isAfter(now)) {
        return;
      }
      if (nextReady == null || readyAt.isBefore(nextReady!)) {
        nextReady = readyAt;
      }
    }

    consider(_lastFeedAction.add(_actionCooldown));
    consider(_lastPlayAction.add(_actionCooldown));
    consider(_lastRestAction.add(_actionCooldown));

    if (nextReady == null) {
      _cooldownTimer = null;
      return;
    }

    final delay = nextReady!.difference(now);
    _cooldownTimer = Timer(delay, () {
      _cooldownTimer = null;
      notifyListeners();
      _scheduleCooldownCheck();
    });
  }

  static int _clamp(int value) => max(minStat, min(value, maxStat));
}

class PetSnapshot {
  const PetSnapshot({
    required this.hunger,
    required this.energy,
    required this.happiness,
    required this.lastUpdated,
    required this.shellStyle,
    required this.character,
  });

  final int hunger;
  final int energy;
  final int happiness;
  final DateTime lastUpdated;
  final PetShellStyle shellStyle;
  final PetCharacter character;
}

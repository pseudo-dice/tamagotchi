import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/pet_state.dart';
import '../state/theme_state.dart';
import '../widgets/stat_meter.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradientColors = colorScheme.brightness == Brightness.dark
        ? [const Color(0xFF1B1747), const Color(0xFF442B73)]
        : [const Color(0xFFFFD6E8), const Color(0xFFC7D5FF)];
    final onSurface = colorScheme.onSurface;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 60,
                left: 24,
                child: Icon(
                  Icons.auto_awesome,
                  color: const Color(0xFFFFB7E0).withOpacity(0.7),
                  size: 44,
                ),
              ),
              Positioned(
                bottom: 90,
                right: 28,
                child: Icon(
                  Icons.bubble_chart,
                  color: const Color(0xFFB5C5FF).withOpacity(0.65),
                  size: 38,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'PocketPet Dreamscape',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              letterSpacing: 4,
                              color: onSurface,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Nurture a kawaii companion with rituals, sparkles, and charm.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              letterSpacing: 1.4,
                              color: onSurface.withOpacity(0.82),
                            ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: 220,
                        child: FilledButton.icon(
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Start Playing'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 22,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const CustomizationScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 12,
                right: 12,
                child: _ThemeToggleButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomizationScreen extends StatelessWidget {
  const CustomizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradientColors = colorScheme.brightness == Brightness.dark
        ? [const Color(0xFF1B1747), const Color(0xFF442B73)]
        : [const Color(0xFFFFD6E8), const Color(0xFFC7D5FF)];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 12,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
              const Positioned(
                top: 12,
                right: 12,
                child: _ThemeToggleButton(),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _AppearanceSelector(),
                      const SizedBox(height: 24),
                      Consumer<ThemeState>(
                        builder: (context, themeState, _) {
                          return SizedBox(
                            width: 230,
                            child: OutlinedButton.icon(
                              icon: Icon(
                                themeState.isDark
                                    ? Icons.light_mode_rounded
                                    : Icons.dark_mode_rounded,
                              ),
                              label: Text(
                                themeState.isDark
                                    ? 'Switch to Light Mode'
                                    : 'Switch to Dark Mode',
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                side: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer
                                      .withOpacity(0.4),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                              ),
                              onPressed: themeState.toggle,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: 240,
                        child: FilledButton.icon(
                          icon: const Icon(Icons.rocket_launch_rounded),
                          label: const Text('Enter PocketPet'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 22,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const PocketPetScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PocketPetScreen extends StatelessWidget {
  const PocketPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradientColors = colorScheme.brightness == Brightness.dark
        ? [const Color(0xFF1B1747), const Color(0xFF442B73)]
        : [const Color(0xFFFFD6E8), const Color(0xFFC7D5FF)];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 12,
                child: IconButton(
                  icon: const Icon(Icons.tune_rounded),
                  tooltip: 'Back to customization',
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const CustomizationScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),
              const Positioned(
                top: 12,
                right: 12,
                child: _ThemeToggleButton(),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<PetState>(
                        builder: (context, pet, _) => _DeviceShell(pet: pet),
                      ),
                      const SizedBox(height: 36),
                      const _StatusPanel(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppearanceSelector extends StatelessWidget {
  const _AppearanceSelector();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<PetState>(
      builder: (context, pet, _) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 440),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer.withOpacity(0.7),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: Colors.black.withOpacity(0.05),
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 18,
                color: Colors.black12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customize Your PocketPet',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      letterSpacing: 2,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Shell Style',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: PetShellStyle.values.map((style) {
                  final palette = _shellPalettes[style]!;
                  final isSelected = pet.shellStyle == style;

                  return ChoiceChip(
                    label: Text(style.label),
                    selected: isSelected,
                    onSelected: (_) => pet.selectShell(style),
                    avatar: CircleAvatar(
                      backgroundColor: palette.baseColor,
                      child: Icon(
                        Icons.egg,
                        color: palette.accentColor,
                        size: 18,
                      ),
                    ),
                    shape: const StadiumBorder(),
                    selectedColor: palette.baseColor.withOpacity(0.9),
                    labelStyle:
                        Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isSelected
                                  ? Colors.black
                                  : Theme.of(context).colorScheme.onSurface,
                              fontSize: 12,
                              letterSpacing: 1.5,
                            ),
                    backgroundColor: palette.accentColor.withOpacity(0.6),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              Text(
                'Character',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: PetCharacter.values.map((character) {
                  final info = _characterInfo[character]!;
                  final isSelected = pet.character == character;

                  return ChoiceChip(
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.label,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontSize: 12,
                                    letterSpacing: 1.5,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          info.tagline,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontSize: 11,
                                    letterSpacing: 1,
                                  ),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (_) => pet.selectCharacter(character),
                    avatar: CircleAvatar(
                      backgroundColor: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      child: Icon(
                        info.icon,
                        color: isSelected ? Colors.white : Colors.black87,
                        size: 18,
                      ),
                    ),
                    shape: const StadiumBorder(),
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    selectedColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    showCheckmark: false,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeviceShell extends StatelessWidget {
  const _DeviceShell({
    required this.pet,
    this.showDetails = false,
  });

  final PetState pet;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    final palette = _shellPalettes[pet.shellStyle] ??
        _shellPalettes[PetState.defaultShellStyle]!;
    final brightness = Theme.of(context).brightness;
    final shellColor =
        pet.isCritical ? const Color(0xFFFF6395) : palette.baseColor;
    final accentColor = pet.isCritical
        ? const Color(0xFFFFE0EF)
        : palette.accentFor(brightness);
    final screenColor = palette.screenFor(brightness);
    final characterDetails = _characterInfo[pet.character];

    return Container(
      width: 324,
      constraints: const BoxConstraints(minHeight: 430),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.4),
          radius: 0.85,
          colors: [shellColor, shellColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(260),
        border: Border.all(color: Colors.black.withOpacity(0.12), width: 3),
        boxShadow: [
          BoxShadow(
            blurRadius: 32,
            color: Colors.black.withOpacity(0.32),
            offset: const Offset(0, 24),
          ),
          BoxShadow(
            blurRadius: 14,
            color: Colors.black.withOpacity(0.14),
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PocketPet',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 13,
                    color: const Color(0xFF1E293B),
                    letterSpacing: 3,
                  ),
            ),
            if (showDetails && characterDetails != null) ...[
              const SizedBox(height: 8),
              Text(
                pet.character.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 2,
                      color: const Color(0xFF1F2937),
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                characterDetails.tagline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 8,
                      letterSpacing: 1.2,
                      color: Colors.black.withOpacity(0.55),
                    ),
              ),
            ] else
              const SizedBox(height: 12),
            _DeviceScreen(
              pet: pet,
              accentColor: accentColor,
              screenColor: screenColor,
              animation: pet.currentAnimation,
            ),
            const SizedBox(height: 24),
            _DeviceButtons(pet: pet, accentColor: accentColor),
            TextButton(
              onPressed: pet.reset,
              style: TextButton.styleFrom(
                shape: const StadiumBorder(),
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                textStyle: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 2),
              ),
              child: const Text('RESET'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceScreen extends StatelessWidget {
  const _DeviceScreen({
    required this.pet,
    required this.accentColor,
    required this.screenColor,
    required this.animation,
  });

  final PetState pet;
  final Color accentColor;
  final Color screenColor;
  final PetAnimationType? animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: screenColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black.withOpacity(0.35), width: 4),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.14),
              blurRadius: 14,
              offset: const Offset(0, 6)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Column(
        children: [
          _ScreenIcons(pet: pet, accentColor: accentColor),
          const SizedBox(height: 12),
          Expanded(
            child: Center(
              child: _PetSprite(
                character: pet.character,
                isSleepy: pet.energyPercent < 0.28,
                isHungry: pet.hungerPercent < 0.3,
                animation: animation,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _ScreenStats(pet: pet),
          const SizedBox(height: 6),
          Text(
            'MOOD ${pet.mood.toUpperCase()}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  letterSpacing: 2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );
  }
}

class _ScreenIcons extends StatelessWidget {
  const _ScreenIcons({required this.pet, required this.accentColor});

  final PetState pet;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.onSurface;
    final brightness = Theme.of(context).brightness;
    final trayColor = brightness == Brightness.dark
        ? Color.alphaBlend(
            Theme.of(context).colorScheme.surface.withOpacity(0.35),
            accentColor,
          )
        : accentColor;

    Color iconColor(double value) {
      if (value >= 0.6) {
        return baseColor;
      }
      if (value >= 0.35) {
        return baseColor.withOpacity(0.7);
      }
      return baseColor.withOpacity(0.35);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: trayColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.restaurant_menu,
              size: 18, color: iconColor(pet.hungerPercent)),
          Icon(Icons.sentiment_satisfied_alt,
              size: 18, color: iconColor(pet.happinessPercent)),
          Icon(Icons.bedtime, size: 18, color: iconColor(pet.energyPercent)),
          Icon(Icons.settings, size: 18, color: baseColor.withOpacity(0.35)),
        ],
      ),
    );
  }
}

class _ScreenStats extends StatelessWidget {
  const _ScreenStats({required this.pet});

  final PetState pet;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    TextStyle valueStyle(double value) {
      final base = Theme.of(context).textTheme.labelSmall ??
          const TextStyle(fontSize: 10);
      final opacity = value >= 0.55
          ? 1.0
          : value >= 0.3
              ? 0.7
              : 0.45;
      return base.copyWith(fontSize: 12, color: onSurface.withOpacity(opacity));
    }

    Widget stat(String label, double value) {
      final percent = (value * 100).round().toString().padLeft(3, '0');
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  letterSpacing: 2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 4),
          Text(percent, style: valueStyle(value)),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        stat('HUN', pet.hungerPercent),
        stat('HAP', pet.happinessPercent),
        stat('ENG', pet.energyPercent),
      ],
    );
  }
}

class _DeviceButtons extends StatelessWidget {
  const _DeviceButtons({required this.pet, required this.accentColor});

  final PetState pet;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _DeviceButton(
          label: 'FEED',
          icon: Icons.restaurant_rounded,
          onPressed: pet.feed,
          enabled: pet.canFeed,
          accentColor: accentColor,
        ),
        _DeviceButton(
          label: 'PLAY',
          icon: Icons.sports_esports_rounded,
          onPressed: pet.play,
          enabled: pet.canPlay,
          accentColor: accentColor,
        ),
        _DeviceButton(
          label: 'REST',
          icon: Icons.bedtime_rounded,
          onPressed: pet.rest,
          enabled: pet.canRest,
          accentColor: accentColor,
        ),
      ],
    );
  }
}

class _DeviceButton extends StatelessWidget {
  const _DeviceButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.enabled,
    required this.accentColor,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool enabled;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            minimumSize: const Size(74, 74),
            backgroundColor: accentColor,
            disabledBackgroundColor: accentColor.withOpacity(0.35),
            elevation: 5,
            shadowColor: Colors.black54,
            foregroundColor: Colors.black,
            disabledForegroundColor: Colors.black.withOpacity(0.35),
          ),
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: enabled
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.45),
                fontSize: 12,
                letterSpacing: 2,
              ),
        ),
      ],
    );
  }
}

class _PetSprite extends StatefulWidget {
  const _PetSprite({
    required this.character,
    required this.isSleepy,
    required this.isHungry,
    required this.animation,
  });

  final PetCharacter character;
  final bool isSleepy;
  final bool isHungry;
  final PetAnimationType? animation;

  @override
  State<_PetSprite> createState() => _PetSpriteState();
}

class _PetSpriteState extends State<_PetSprite>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  PetAnimationType? _lastPlayed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _PetSprite oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != null && widget.animation != _lastPlayed) {
      _lastPlayed = widget.animation;
      _controller.forward(from: 0);
    } else if (widget.animation == null && oldWidget.animation != null) {
      _lastPlayed = null;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData? _emoteIconFor(PetAnimationType? animation) {
    switch (animation) {
      case PetAnimationType.feed:
        return Icons.restaurant_menu_rounded;
      case PetAnimationType.play:
        return Icons.sports_esports_rounded;
      case PetAnimationType.rest:
        return Icons.bedtime_rounded;
      case null:
        return null;
    }
  }

  String _emoteLabelFor(PetAnimationType? animation) {
    switch (animation) {
      case PetAnimationType.feed:
        return 'EAT';
      case PetAnimationType.play:
        return 'PLAY';
      case PetAnimationType.rest:
        return 'REST';
      case null:
        return '';
    }
  }

  Color _emoteTint(PetAnimationType animation, ColorScheme scheme) {
    switch (animation) {
      case PetAnimationType.feed:
        return scheme.secondary;
      case PetAnimationType.play:
        return scheme.primary;
      case PetAnimationType.rest:
        return scheme.tertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sprites = _spriteSets[widget.character] ??
        _spriteSets[PetState.defaultCharacter]!;
    final pattern = widget.isSleepy
        ? sprites.sleep
        : widget.isHungry
            ? sprites.sad
            : sprites.happy;
    final emoteIcon = _emoteIconFor(widget.animation);
    final emoteLabel = _emoteLabelFor(widget.animation);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final badgeColor = theme.brightness == Brightness.dark
        ? colorScheme.onSurface.withOpacity(0.18)
        : Colors.white.withOpacity(0.88);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: CustomPaint(
              key: ValueKey<String>(
                '${widget.character.name}-${pattern.join()}',
              ),
              size: const Size(180, 180),
              painter: _PetSpritePainter(
                pattern: pattern,
                accentColor: sprites.accentColor,
              ),
            ),
          ),
          if (emoteIcon != null)
            Positioned(
              top: 18,
              child: AnimatedOpacity(
                opacity: widget.animation != null ? 1 : 0,
                duration: const Duration(milliseconds: 160),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colorScheme.onSurface.withOpacity(0.12),
                      width: 1.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          emoteIcon,
                          color: _emoteTint(widget.animation!, colorScheme),
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          emoteLabel,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    letterSpacing: 1.6,
                                    color: colorScheme.onSurface,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PetSpritePainter extends CustomPainter {
  _PetSpritePainter({required this.pattern, required this.accentColor});

  final List<String> pattern;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    const padding = 8.0;
    final paintFill = Paint()..color = const Color(0xFF1E2B35);
    final paintAccent = Paint()..color = accentColor;
    final rows = pattern.length;
    final cols = pattern.first.length;
    final cellSize = Size(
      (size.width - padding * 2) / cols,
      (size.height - padding * 2) / rows,
    );

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final cell = pattern[r][c];
        if (cell == '0') {
          continue;
        }
        final paint = cell == '2' ? paintAccent : paintFill;
        final rect = Rect.fromLTWH(
          padding + c * cellSize.width,
          padding + r * cellSize.height,
          cellSize.width,
          cellSize.height,
        );
        canvas.drawRect(rect.deflate(1), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PetSpritePainter oldDelegate) {
    return pattern != oldDelegate.pattern ||
        accentColor != oldDelegate.accentColor;
  }
}

class _SpriteSet {
  const _SpriteSet({
    required this.happy,
    required this.sad,
    required this.sleep,
    required this.accentColor,
  });

  final List<String> happy;
  final List<String> sad;
  final List<String> sleep;
  final Color accentColor;
}

const _SpriteSet _pixelPupSprites = _SpriteSet(
  happy: [
    '0000111100000',
    '0001111110000',
    '0011112111000',
    '0111100111100',
    '0111022011100',
    '1111111111110',
    '1110111110110',
    '1110111110110',
    '0111212211110',
    '0012012012000',
    '0001200012000',
  ],
  sad: [
    '0000111100000',
    '0001111110000',
    '0011112111000',
    '0111100111100',
    '0111022011100',
    '1111111111110',
    '1100111110010',
    '1100111110010',
    '0110111110100',
    '0011122211100',
    '0001111111000',
  ],
  sleep: [
    '0000011110000',
    '0000111111000',
    '0001111111100',
    '0011110011110',
    '0011100001110',
    '1111111111111',
    '1110111110111',
    '1110111110111',
    '0111111111110',
    '0011111111100',
    '0000122120000',
  ],
  accentColor: Color(0xFFA8E06E),
);

const _SpriteSet _roboSproutSprites = _SpriteSet(
  happy: [
    '0000222200000',
    '0002111120000',
    '0021111112000',
    '0211100111200',
    '0211000011200',
    '2111333311120',
    '2113222231120',
    '2113222231120',
    '0211111111200',
    '0021200212000',
    '0000222200000',
  ],
  sad: [
    '0000222200000',
    '0002111120000',
    '0021111112000',
    '0211100111200',
    '0211000011200',
    '2111333311120',
    '2110022230020',
    '2110022230020',
    '0211022231200',
    '0021111112000',
    '0000222200000',
  ],
  sleep: [
    '0000011100000',
    '0000222210000',
    '0002111112000',
    '0021100111200',
    '0211000011200',
    '2111333311120',
    '2113222231120',
    '2113222231120',
    '0211111111200',
    '0022200222000',
    '0000022200000',
  ],
  accentColor: Color(0xFF6EE7FF),
);

const _SpriteSet _cosmicBuddySprites = _SpriteSet(
  happy: [
    '0000011100000',
    '0001222210000',
    '0012222222100',
    '0122200222200',
    '0122000002200',
    '2222111112220',
    '2222112112220',
    '2222112112220',
    '0122222222200',
    '0012022202100',
    '0000110010000',
  ],
  sad: [
    '0000011100000',
    '0001222210000',
    '0012222222100',
    '0122200222200',
    '0122000002200',
    '2222111112220',
    '2200112110020',
    '2200112110020',
    '0120222222200',
    '0012220022100',
    '0001222210000',
  ],
  sleep: [
    '0000001100000',
    '0000012210000',
    '0001222221000',
    '0012200222100',
    '0122000002200',
    '2222222222220',
    '2222122212220',
    '2222122212220',
    '0122222222200',
    '0012222222100',
    '0000011100000',
  ],
  accentColor: Color(0xFFFFCF66),
);

const Map<PetCharacter, _SpriteSet> _spriteSets = {
  PetCharacter.pixelPup: _pixelPupSprites,
  PetCharacter.roboSprout: _roboSproutSprites,
  PetCharacter.cosmicBuddy: _cosmicBuddySprites,
};

class _StatusPanel extends StatelessWidget {
  const _StatusPanel();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<PetState>(
      builder: (context, pet, _) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 360),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer.withOpacity(0.7),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: Colors.black.withOpacity(0.04), width: 2),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 20, color: Colors.black12, offset: Offset(0, 8)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'STATUS CHECK',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.92),
                      letterSpacing: 3,
                    ),
              ),
              const SizedBox(height: 18),
              StatMeter(
                  label: 'Hunger',
                  value: pet.hungerPercent,
                  color: colorScheme.primary),
              const SizedBox(height: 14),
              StatMeter(
                  label: 'Energy',
                  value: pet.energyPercent,
                  color: colorScheme.tertiary),
              const SizedBox(height: 14),
              StatMeter(
                  label: 'Happiness',
                  value: pet.happinessPercent,
                  color: colorScheme.secondary),
            ],
          ),
        );
      },
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).colorScheme.surfaceVariant;

    return Consumer<ThemeState>(
      builder: (context, themeState, _) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: cardColor.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(color: Colors.black.withOpacity(0.1), width: 1.5),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 12, color: Colors.black26, offset: Offset(0, 4)),
            ],
          ),
          child: IconButton(
            tooltip: themeState.isDark
                ? 'Switch to light mode'
                : 'Switch to dark mode',
            icon: Icon(
              themeState.isDark
                  ? Icons.wb_sunny_rounded
                  : Icons.nights_stay_rounded,
            ),
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: themeState.toggle,
          ),
        );
      },
    );
  }
}

class _ShellPalette {
  const _ShellPalette({
    required this.baseColor,
    required this.accentColor,
    required this.screenColor,
    this.accentColorDark,
    this.screenColorDark,
  });

  final Color baseColor;
  final Color accentColor;
  final Color screenColor;
  final Color? accentColorDark;
  final Color? screenColorDark;

  Color accentFor(Brightness brightness) {
    return brightness == Brightness.dark
        ? accentColorDark ?? accentColor
        : accentColor;
  }

  Color screenFor(Brightness brightness) {
    return brightness == Brightness.dark
        ? screenColorDark ?? screenColor
        : screenColor;
  }
}

const Map<PetShellStyle, _ShellPalette> _shellPalettes = {
  PetShellStyle.oceanWave: _ShellPalette(
    baseColor: Color(0xFF7BD8FF),
    accentColor: Color(0xFFD9F4FF),
    screenColor: Color(0xFFE1F4FF),
    accentColorDark: Color(0xFF3BA6D8),
    screenColorDark: Color(0xFF1D2F47),
  ),
  PetShellStyle.candyPop: _ShellPalette(
    baseColor: Color(0xFFFF9BD4),
    accentColor: Color(0xFFFFF5FB),
    screenColor: Color(0xFFFFEDF7),
    accentColorDark: Color(0xFFE64A9B),
    screenColorDark: Color(0xFF3A2340),
  ),
  PetShellStyle.midnightStorm: _ShellPalette(
    baseColor: Color(0xFF7C6CFF),
    accentColor: Color(0xFFE8E6FF),
    screenColor: Color(0xFF22264A),
    accentColorDark: Color(0xFF4C48D1),
    screenColorDark: Color(0xFF181B35),
  ),
};

class _CharacterInfo {
  const _CharacterInfo({
    required this.icon,
    required this.tagline,
  });

  final IconData icon;
  final String tagline;
}

const Map<PetCharacter, _CharacterInfo> _characterInfo = {
  PetCharacter.pixelPup: _CharacterInfo(
    icon: Icons.pets_rounded,
    tagline: 'Loyal retro sidekick',
  ),
  PetCharacter.roboSprout: _CharacterInfo(
    icon: Icons.auto_awesome_rounded,
    tagline: 'Curious tech botanist',
  ),
  PetCharacter.cosmicBuddy: _CharacterInfo(
    icon: Icons.star_rounded,
    tagline: 'Dreamy stargazing pal',
  ),
};

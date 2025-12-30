import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/pet_state.dart';
import '../widgets/action_button.dart';
import '../widgets/stat_meter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Tamagotchi Pet'),
        backgroundColor: colorScheme.surfaceVariant,
        elevation: 0,
      ),
      body: const ResponsiveLayout(),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 720) {
          return const _WideLayout();
        }
        return const _NarrowLayout();
      },
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout();

  @override
  Widget build(BuildContext context) {
    return const _HomeContents(
      direction: Axis.vertical,
      spacing: 24,
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 920,
        child: _HomeContents(
          direction: Axis.horizontal,
          spacing: 32,
        ),
      ),
    );
  }
}

class _HomeContents extends StatelessWidget {
  const _HomeContents({
    required this.direction,
    required this.spacing,
  });

  final Axis direction;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final isWide = direction == Axis.horizontal;

    return Flex(
      direction: direction,
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: isWide ? 2 : 0,
          child: const _PetPanel(),
        ),
        SizedBox(height: isWide ? 0 : spacing, width: isWide ? spacing : 0),
        Flexible(
          flex: 3,
          child: const _StatsAndActions(),
        ),
      ],
    );
  }
}

class _PetPanel extends StatelessWidget {
  const _PetPanel();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Consumer<PetState>(
          builder: (context, pet, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: pet.isCritical
                        ? colorScheme.errorContainer
                        : colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    pet.isCritical ? Icons.mood_bad : Icons.pets,
                    size: 96,
                    color: pet.isCritical
                        ? colorScheme.onErrorContainer
                        : colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  pet.mood,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Updated just now',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatsAndActions extends StatelessWidget {
  const _StatsAndActions();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<PetState>(
      builder: (context, pet, _) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                StatMeter(
                  label: 'Hunger',
                  value: pet.hungerPercent,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 16),
                StatMeter(
                  label: 'Energy',
                  value: pet.energyPercent,
                  color: colorScheme.tertiary,
                ),
                const SizedBox(height: 16),
                StatMeter(
                  label: 'Happiness',
                  value: pet.happinessPercent,
                  color: colorScheme.secondary,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ActionButton(
                      icon: Icons.restaurant,
                      label: 'Feed',
                      onPressed: pet.feed,
                    ),
                    ActionButton(
                      icon: Icons.sports_esports,
                      label: 'Play',
                      onPressed: pet.play,
                    ),
                    ActionButton(
                      icon: Icons.bedtime,
                      label: 'Rest',
                      onPressed: pet.rest,
                    ),
                    ActionButton(
                      icon: Icons.restart_alt,
                      label: 'Reset',
                      onPressed: pet.reset,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

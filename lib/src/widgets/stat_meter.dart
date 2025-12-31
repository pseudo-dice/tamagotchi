import 'package:flutter/material.dart';

class StatMeter extends StatelessWidget {
  const StatMeter({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0.0, 1.0).toDouble();
    const segments = 12;
    final filledSegments = (clampedValue * segments).round().clamp(0, segments);
    final percentLabel =
        (clampedValue * 100).round().toString().padLeft(3, '0');
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.labelLarge?.copyWith(
                letterSpacing: 1.8,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '$percentLabel%',
              style: textTheme.labelMedium?.copyWith(
                letterSpacing: 1.2,
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 18,
          child: Row(
            children: List.generate(segments, (index) {
              final isFilled = index < filledSegments;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index == segments - 1 ? 0 : 2),
                  decoration: BoxDecoration(
                    color: isFilled ? color : color.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.black.withOpacity(isFilled ? 0.2 : 0.08),
                      width: 1,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

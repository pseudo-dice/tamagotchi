import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'state/theme_state.dart';

class PocketPetApp extends StatelessWidget {
  const PocketPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: (context, themeState, _) {
        TextTheme buildTextTheme(Color tone) {
          final base = GoogleFonts.notoSansJpTextTheme();
          final heading = GoogleFonts.mochiyPopOne(
            textStyle: TextStyle(
              color: tone,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w800,
            ),
          );

          final adjusted = base.apply(
            bodyColor: tone,
            displayColor: tone,
          );

          return adjusted.copyWith(
            headlineLarge: heading.copyWith(fontSize: 36, height: 1.2),
            headlineMedium: heading.copyWith(fontSize: 32, height: 1.2),
            headlineSmall: heading.copyWith(fontSize: 28, height: 1.25),
            titleLarge: heading.copyWith(fontSize: 24, height: 1.25),
            titleMedium: heading.copyWith(fontSize: 22, height: 1.25),
            titleSmall: heading.copyWith(fontSize: 18, height: 1.3),
            bodyLarge: adjusted.bodyLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
            bodyMedium: adjusted.bodyMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
            bodySmall: adjusted.bodySmall?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
            labelLarge: adjusted.labelLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
            labelMedium: adjusted.labelMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.3,
            ),
            labelSmall: adjusted.labelSmall?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          );
        }

        final lightScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF85B8),
          brightness: Brightness.light,
        ).copyWith(
          surface: const Color(0xFFFFF8FC),
          surfaceVariant: const Color(0xFFFFEDF6),
          primaryContainer: const Color(0xFFFFCFE4),
          secondary: const Color(0xFF809AFF),
          secondaryContainer: const Color(0xFFE6ECFF),
          tertiary: const Color(0xFF70CFBA),
          onSurface: Colors.black,
          onBackground: Colors.black,
          onSecondaryContainer: Colors.black,
        );

        final darkScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFF6150D2),
          brightness: Brightness.dark,
        ).copyWith(
          surface: const Color(0xFF111325),
          surfaceVariant: const Color(0xFF1F2543),
          primaryContainer: const Color(0xFF2F3168),
          secondaryContainer: const Color(0xFF273058),
          tertiary: const Color(0xFF48AF9A),
          onSurface: Colors.white,
          onBackground: Colors.white,
          onSecondaryContainer: Colors.white,
        );

        final lightText = buildTextTheme(Colors.black);
        final darkText = buildTextTheme(Colors.white);

        return MaterialApp(
          title: 'PocketPet',
          themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            colorScheme: lightScheme,
            scaffoldBackgroundColor: lightScheme.surface,
            textTheme: lightText,
            useMaterial3: true,
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                shape: const StadiumBorder(),
                textStyle: GoogleFonts.mochiyPopOne(
                  fontSize: 14,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: darkScheme,
            scaffoldBackgroundColor: darkScheme.surface,
            textTheme: darkText,
            useMaterial3: true,
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                shape: const StadiumBorder(),
                textStyle: GoogleFonts.mochiyPopOne(
                  fontSize: 14,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
          home: const StartScreen(),
        );
      },
    );
  }
}

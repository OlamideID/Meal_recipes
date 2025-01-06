import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// StateNotifier to manage ThemeMode state (light/dark).
class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const String _themeKey = 'theme_mode';

  ThemeNotifier() : super(ThemeMode.light) {
    _initializeTheme();
  }

  /// Initialize theme mode from SharedPreferences or set default for web.
  Future<void> _initializeTheme() async {
    try {
      if (kIsWeb) {
        state = ThemeMode.light; // Default theme for web
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;
      state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      debugPrint('Error loading theme from SharedPreferences: $e');
    }
  }

  /// Toggle theme mode and save the preference.
  Future<void> toggleTheme(bool isDarkMode) async {
    try {
      state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDarkMode);
    } catch (e) {
      debugPrint('Error saving theme to SharedPreferences: $e');
    }
  }
}

/// Riverpod provider for ThemeNotifier.
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

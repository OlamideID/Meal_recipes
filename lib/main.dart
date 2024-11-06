import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/Screens/tabs.dart';
import 'package:meals/providers/theme_provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(
        255,
        131,
        57,
        0,
      ),
      brightness: Brightness.light),
  textTheme: GoogleFonts.latoTextTheme(Typography.blackCupertino),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
      255,
      131,
      57,
      0,
    ),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.latoTextTheme(Typography.whiteCupertino),
);


void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: const TabsScreen());
  }
}

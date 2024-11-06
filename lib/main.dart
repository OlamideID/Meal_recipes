import 'package:device_preview/device_preview.dart';
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
    return DevicePreview(
      backgroundColor: Colors.white,
      enabled: true,
      availableLocales: const [
        Locale('en', 'US'),
      ],
      devices: [
        Devices.macOS.macBookPro,
        Devices.linux.laptop,
        Devices.android.samsungGalaxyA50,
        Devices.android.samsungGalaxyS20,
        Devices.ios.iPhone13ProMax,
        Devices.ios.iPhoneSE,
        Devices.windows.laptop,
      ],
      tools: const [
        DeviceSection(
          model: true,
          orientation: false,
          frameVisibility: false,
          virtualKeyboard: false,
        )
      ],
      builder: (context) => MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const TabsScreen()),
    );
  }
}

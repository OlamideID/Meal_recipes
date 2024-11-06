import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_provider.dart';

class MyTile extends ConsumerWidget {
  const MyTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeMode.dark;

    return SwitchListTile(
      title: Text(
        isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        style: const TextStyle(fontSize: 20),
      ),
      value: isDarkMode,
      onChanged: (bool value) {
        themeNotifier.toggleTheme(value); // Toggle between light and dark mode
      },
    );
  }
}

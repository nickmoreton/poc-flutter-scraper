import 'package:flutter/material.dart';

class ThemeSwitcher extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const ThemeSwitcher({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.light_mode),
        Switch(
          value: isDarkMode,
          onChanged: onThemeChanged,
        ),
        const Icon(Icons.dark_mode),
      ],
    );
  }
}

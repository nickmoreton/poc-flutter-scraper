// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/release_selector.dart';
import '../widgets/theme_switcher.dart';
import '../services/url_fetcher.dart';
import 'markdown_screen.dart';
import 'plain_text_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;
  String? _selectedReleasePage;
  final UrlFetcherService _urlFetcher = UrlFetcherService();

  Future<void> _fetchAndNavigate(BuildContext context, bool isMarkdown) async {
    if (_selectedReleasePage == null) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final model = await _urlFetcher.fetchReleaseNotes(_selectedReleasePage!);

      // Pop the loading dialog
      Navigator.pop(context);

      final formattedContent =
          isMarkdown ? model.toMarkdown() : model.toPlainText();

      // Navigate to the appropriate screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => isMarkdown
              ? MarkdownScreen(
                  content: formattedContent,
                  releaseVersion: _selectedReleasePage!,
                )
              : PlainTextScreen(
                  content: formattedContent,
                  releaseVersion: _selectedReleasePage!,
                ),
        ),
      );
    } catch (e) {
      // Pop the loading dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch release notes: $e'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Generate Docs Summary'),
          actions: [
            ThemeSwitcher(
              isDarkMode: _isDarkMode,
              onThemeChanged: (value) => setState(() => _isDarkMode = value),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ReleaseSelector(
                selectedRelease: _selectedReleasePage,
                onReleaseSelected: (release) {
                  setState(() => _selectedReleasePage = release);
                },
              ),
              if (_selectedReleasePage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _fetchAndNavigate(context, true),
                        child: const Text('View Markdown'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _fetchAndNavigate(context, false),
                        child: const Text('View Plain Text'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

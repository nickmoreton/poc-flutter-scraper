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
  String? _fetchedContent;
  bool _isLoading = false;
  String? _errorMessage;
  final UrlFetcherService _urlFetcher = UrlFetcherService();

  Future<void> _fetchReleaseNotes() async {
    if (_selectedReleasePage == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final content =
          await _urlFetcher.fetchReleaseNotes(_selectedReleasePage!);
      setState(() {
        _fetchedContent = content;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch release notes: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToMarkdownView() {
    if (_fetchedContent != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MarkdownScreen(
            content: _fetchedContent!,
            releaseVersion: _selectedReleasePage!,
          ),
        ),
      );
    }
  }

  void _navigateToPlainTextView() {
    if (_fetchedContent != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlainTextScreen(
            content: _fetchedContent!,
            releaseVersion: _selectedReleasePage!,
          ),
        ),
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
                  setState(() {
                    _selectedReleasePage = release;
                    _fetchedContent = null;
                  });
                  if (release != null) {
                    _fetchReleaseNotes();
                  }
                },
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              if (_selectedReleasePage != null && _fetchedContent != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _navigateToMarkdownView,
                        child: const Text('View Markdown'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _navigateToPlainTextView,
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

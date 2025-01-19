// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/content_panel.dart';
import '../widgets/release_selector.dart';
import '../widgets/theme_switcher.dart';
import '../services/url_fetcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;
  String? _selectedReleasePage;
  final TextEditingController _leftTextController = TextEditingController();
  final TextEditingController _rightTextController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  final UrlFetcherService _urlFetcher = UrlFetcherService();

  @override
  void dispose() {
    _leftTextController.dispose();
    _rightTextController.dispose();
    super.dispose();
  }

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
        _leftTextController.text = content;
        _rightTextController.text = content;
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
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              if (_selectedReleasePage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ContentPanel(
                          title: 'Markdown',
                          controller: _leftTextController,
                          onGeneratePress: _fetchReleaseNotes,
                          onCopyPress: () {
                            // TODO: Implement copy
                          },
                          isLoading: _isLoading,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ContentPanel(
                          title: 'Plain Text',
                          controller: _rightTextController,
                          onGeneratePress: () {
                            // TODO: Implement plain text conversion
                          },
                          onCopyPress: () {
                            // TODO: Implement copy
                          },
                          isLoading: _isLoading,
                        ),
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

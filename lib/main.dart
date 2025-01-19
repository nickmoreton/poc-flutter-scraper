import 'package:flutter/material.dart';
import 'config.dart'; // Import the config file at the top
import 'services/url_fetcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generate Docs Summary',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDarkMode = false;
  String? _selectedReleasePage;
  final TextEditingController _leftTextController = TextEditingController();
  final TextEditingController _rightTextController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  // Create an instance of UrlFetcherService
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
        // For now, we'll just copy the content to the right panel
        // Later we can add plain text conversion
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

  Widget _buildPanel({
    required String title,
    required TextEditingController controller,
    required VoidCallback onGeneratePress,
    required VoidCallback onCopyPress,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 8,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Content will appear here...',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onGeneratePress,
                  child: const Text('Generate'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onCopyPress,
                  child: const Text('Copy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Generate Docs Summary'),
          actions: [
            Row(
              children: [
                const Icon(Icons.light_mode),
                Switch(
                  value: _isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                  },
                ),
                const Icon(Icons.dark_mode),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // Use wagtailReleases directly from config.dart
                    children: wagtailReleases.entries.map((release) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Text(release.value),
                          selected: _selectedReleasePage == release.key,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedReleasePage =
                                  selected ? release.key : null;
                              if (_selectedReleasePage != null) {
                                print(
                                    'Selected: ${release.value}'); // Debug print
                                print('File: ${release.key}'); // Debug print
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              if (_selectedReleasePage != null) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildPanel(
                          title: 'Markdown',
                          controller: _leftTextController,
                          onGeneratePress: _fetchReleaseNotes,
                          onCopyPress: () {
                            // Add copy logic here
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildPanel(
                          title: 'Plain Text',
                          controller: _rightTextController,
                          onGeneratePress: () {
                            // Add plain text conversion logic here
                          },
                          onCopyPress: () {
                            // Add copy logic here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'config.dart'; // Import the config file at the top

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

  @override
  void dispose() {
    _leftTextController.dispose();
    _rightTextController.dispose();
    super.dispose();
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
              if (_selectedReleasePage != null) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildPanel(
                          title: 'Release Notes',
                          controller: _leftTextController,
                          onGeneratePress: () {
                            // Add generation logic here
                            print(
                                'Generating release notes for: $_selectedReleasePage');
                          },
                          onCopyPress: () {
                            // Add copy logic here
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildPanel(
                          title: 'Summary',
                          controller: _rightTextController,
                          onGeneratePress: () {
                            // Add generation logic here
                            print(
                                'Generating summary for: $_selectedReleasePage');
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

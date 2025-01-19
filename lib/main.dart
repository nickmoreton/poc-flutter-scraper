import 'package:flutter/material.dart';

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

  // Structured data for Wagtail releases
  final Map<String, String> wagtailReleases = {
    "6.3.html": "Wagtail 6.3 (LTS) release notes",
    "6.2.html": "Wagtail 6.2 release notes",
    "6.1.html": "Wagtail 6.1 release notes",
    "6.0.html": "Wagtail 6.0 release notes",
    "5.2.html": "Wagtail 5.2 (LTS) release notes",
    "5.1.html": "Wagtail 5.1 release notes",
    "5.0.html": "Wagtail 5.0 release notes",
    "4.2.html": "Wagtail 4.2 release notes",
    "4.1.html": "Wagtail 4.1 (LTS) release notes",
    "4.0.html": "Wagtail 4.0 release notes",
    "3.0.html": "Wagtail 3.0 release notes",
    "2.16.html": "Wagtail 2.16 release notes",
    "2.15.html": "Wagtail 2.15 (LTS) release notes",
    "2.14.html": "Wagtail 2.14 release notes",
    "2.13.html": "Wagtail 2.13 release notes",
    "2.12.html": "Wagtail 2.12 release notes",
    "2.11.html": "Wagtail 2.11 (LTS) release notes",
    "2.10.html": "Wagtail 2.10 release notes",
    "2.9.html": "Wagtail 2.9 release notes",
    "2.8.html": "Wagtail 2.8 release notes",
    "2.7.html": "Wagtail 2.7 (LTS) release notes",
    "2.6.html": "Wagtail 2.6 release notes",
    "2.5.html": "Wagtail 2.5 release notes",
    "2.4.html": "Wagtail 2.4 release notes",
    "2.3.html": "Wagtail 2.3 (LTS) release notes",
    "2.2.html": "Wagtail 2.2 release notes",
    "2.1.html": "Wagtail 2.1 release notes",
    "2.0.html": "Wagtail 2.0 release notes",
    "1.13.html": "Wagtail 1.13 (LTS) release notes",
    "1.12.html": "Wagtail 1.12 (LTS) release notes",
    "1.11.html": "Wagtail 1.11 release notes",
    "1.10.html": "Wagtail 1.10 release notes",
    "1.9.html": "Wagtail 1.9 release notes",
    "1.8.html": "Wagtail 1.8 (LTS) release notes",
    "1.7.html": "Wagtail 1.7 release notes",
    "1.6.html": "Wagtail 1.6 release notes",
    "1.5.html": "Wagtail 1.5 release notes",
    "1.4.html": "Wagtail 1.4 (LTS) release notes",
    "1.3.html": "Wagtail 1.3 release notes",
    "1.2.html": "Wagtail 1.2 release notes",
    "1.1.html": "Wagtail 1.1 release notes",
    "1.0.html": "Wagtail 1.0 release notes",
  };

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

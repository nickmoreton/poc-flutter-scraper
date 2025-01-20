import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config.dart';

class PlainTextScreen extends StatelessWidget {
  final String content;
  final String releaseVersion;

  const PlainTextScreen({
    Key? key,
    required this.content,
    required this.releaseVersion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Look up the display value using the releaseVersion (key)
    final String displayTitle =
        wagtailReleases[releaseVersion] ?? releaseVersion;

    return Scaffold(
      appBar: AppBar(
        title: Text('Plain Text View - $displayTitle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Add this actions property to the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copy to clipboard', // Optional tooltip
            onPressed: () {
              Clipboard.setData(ClipboardData(text: content)).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Content copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(content),
      ),
    );
  }
}

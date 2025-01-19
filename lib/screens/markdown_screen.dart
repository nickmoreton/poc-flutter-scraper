import 'package:flutter/material.dart';

class MarkdownScreen extends StatelessWidget {
  final String content;
  final String releaseVersion;

  const MarkdownScreen({
    Key? key,
    required this.content,
    required this.releaseVersion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markdown View - $releaseVersion'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(content),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Plain Text View - $releaseVersion'),
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

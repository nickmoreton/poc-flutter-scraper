import 'package:flutter/material.dart';

class ContentPanel extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onGeneratePress;
  final VoidCallback onCopyPress;
  final bool isLoading;

  const ContentPanel({
    Key? key,
    required this.title,
    required this.controller,
    required this.onGeneratePress,
    required this.onCopyPress,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: CircularProgressIndicator(),
                  ),
                ElevatedButton(
                  onPressed: isLoading ? null : onGeneratePress,
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
}

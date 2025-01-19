// lib/services/url_fetcher.dart

import 'dart:io';

import 'package:http/http.dart' as http;
import '../../config.dart';

class UrlFetcherService {
  // Singleton pattern to ensure only one instance
  static final UrlFetcherService _instance = UrlFetcherService._internal();
  factory UrlFetcherService() => _instance;
  UrlFetcherService._internal();

  // Fetch content from URL
  Future<String> fetchReleaseNotes(String version) async {
    try {
      final url = DocsConfig.getReleaseNotesUrl(version);
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: AppConfig.requestTimeout));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw HttpException(
            'Failed to load release notes: ${response.statusCode}');
      }
    } catch (e) {
      if (AppConfig.debugMode) {
        print('Error fetching release notes: $e');
      }
      rethrow;
    }
  }

  // You might want to add more methods here later, such as:
  // Future<String> fetchPlainText(String markdown) async {...}
  // Future<String> fetchSummary(String content) async {...}
}

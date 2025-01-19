// lib/services/url_fetcher.dart

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import '../../config.dart';

class UrlFetcherService {
  static final UrlFetcherService _instance = UrlFetcherService._internal();
  factory UrlFetcherService() => _instance;
  UrlFetcherService._internal();

  Future<String> fetchReleaseNotes(String version) async {
    try {
      final url = DocsConfig.getReleaseNotesUrl(version);

      if (AppConfig.debugMode) {
        print('Fetching from URL: $url');
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'text/html,application/xhtml+xml,application/xml',
          'User-Agent': 'Mozilla/5.0 Flutter/1.0',
        },
      ).timeout(Duration(seconds: AppConfig.requestTimeout));

      if (response.statusCode == 200) {
        // Parse the HTML content and extract the body
        final document = html_parser.parse(response.body);
        final bodyContent = document.body?.text ?? '';
        return bodyContent;
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
}

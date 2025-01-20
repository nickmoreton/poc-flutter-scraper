// lib/config.dart

// Map of Wagtail release notes pages and their display titles
final Map<String, String> wagtailReleases = {
  "6.3.html": "6.3 (LTS)",
  "6.2.html": "6.2",
  "6.1.html": "6.1",
  "6.0.html": "6.0",
  "5.2.html": "5.2 (LTS)",
  "5.1.html": "5.1",
  "5.0.html": "5.0",
  "4.2.html": "4.2",
  "4.1.html": "4.1 (LTS)",
  "4.0.html": "4.0",
  "3.0.html": "3.0",
  "2.16.html": "2.16",
  "2.15.html": "2.15 (LTS)",
  "2.14.html": "2.14",
  "2.13.html": "2.13",
  "2.12.html": "2.12",
  "2.11.html": "2.11 (LTS)",
  "2.10.html": "2.10",
  "2.9.html": "2.9",
  "2.8.html": "2.8",
  "2.7.html": "2.7 (LTS)",
  "2.6.html": "2.6",
  "2.5.html": "2.5",
  "2.4.html": "2.4",
  "2.3.html": "2.3 (LTS)",
  "2.2.html": "2.2",
  "2.1.html": "2.1",
  "2.0.html": "2.0",
  "1.13.html": "1.13 (LTS)",
  "1.12.html": "1.12 (LTS)",
  "1.11.html": "1.11",
  "1.10.html": "1.10",
  "1.9.html": "1.9",
  "1.8.html": "1.8 (LTS)",
  "1.7.html": "1.7",
  "1.6.html": "1.6",
  "1.5.html": "1.5",
  "1.4.html": "1.4 (LTS)",
  "1.3.html": "1.3",
  "1.2.html": "1.2",
  "1.1.html": "1.1",
  "1.0.html": "1.0",
};

// Documentation URLs and paths
class DocsConfig {
  // Base URL for Wagtail documentation
  static const String baseUrl = 'https://docs.wagtail.org/en/stable';

  // Release notes specific paths
  static const String releaseNotesPath = 'releases';

  // Helper method to get full URL for a specific release
  static String getReleaseNotesUrl(String version) {
    return '$baseUrl/$releaseNotesPath/$version';
  }
}

// Optional: Add a class for app-wide configuration
class AppConfig {
  // App name and version
  static const String appName = 'Wagtail Release Notes Generator';
  static const String appVersion = '1.0.0';

  // API configuration (for future use)
  static const int requestTimeout = 30; // seconds

  // Default settings
  static const bool debugMode = true;
}

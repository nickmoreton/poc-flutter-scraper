// lib/config.dart

// Map of Wagtail release notes pages and their display titles
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

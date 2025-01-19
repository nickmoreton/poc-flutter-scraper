// lib/models/release_notes_model.dart

import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

String normalizeTitle(String title) {
  // Implement title normalization similar to Python's normalize_title
  return title.replaceAll('¶', '').trim().capitalize();
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

class DetailSection {
  final Element soup;
  late String url;
  String? title;
  List<Map<String, String>> subSections = [];

  DetailSection({required this.soup, required this.url}) {
    parseSubSections();
  }

  void parseSubSections() {
    final h3Element = soup.querySelector('h3');
    if (h3Element != null) {
      title = normalizeTitle(h3Element.text);
    }

    final sectionId = soup.attributes['id'];
    if (sectionId != null) {
      url = '$url#$sectionId';
    }
  }

  Map<String, String> getSubSection(int index) {
    return subSections[index];
  }
}

class Section {
  final Element soup;
  final String url;
  String? title;
  List<DetailSection> subSections = [];

  Section({required this.soup, required this.url}) {
    parseSubSections();
  }

  void parseSubSections() {
    final h2Element = soup.querySelector('h2');
    if (h2Element != null) {
      title = normalizeTitle(h2Element.text);
    }

    final subSectionsSoup = soup.querySelectorAll('section');
    for (var subSection in subSectionsSoup) {
      subSections.add(DetailSection(soup: subSection, url: url));
    }
  }

  DetailSection getSubSection(int index) {
    return subSections[index];
  }
}

class ReleaseNotesModel {
  final String url;
  List<Section> optionalSections = [];
  List<Section> sections = [];
  String? mainTitle;
  String? mainUrl;
  late Element soup;

  ReleaseNotesModel({required this.url});

  Future<void> initialize(String htmlContent) async {
    soup = html_parser.parse(htmlContent).documentElement!;
    await parseSections();
  }

  Future<void> parseSections() async {
    final main = soup.querySelector('main[id="main"][role="main"]');
    if (main == null) return;

    final mainSection = main.querySelector('section');
    if (mainSection == null) return;

    final mainHeading = mainSection.querySelector('h1');
    if (mainHeading != null) {
      mainTitle = normalizeTitle(mainHeading.text);

      final anchor = mainHeading.querySelector('a');
      if (anchor != null && anchor.attributes.containsKey('href')) {
        final href = anchor.attributes['href']!.replaceAll('#', '').trim();
        mainUrl = '$url#$href';
      }
    }

    final sectionsSoup = mainSection.querySelectorAll('section');
    for (var section in sectionsSoup) {
      final heading = section.querySelector('h2');
      if (heading != null) {
        final sectionTitle = heading.text;
        if (sectionTitle.toLowerCase().contains("what's new")) {
          optionalSections.add(Section(soup: section, url: url));
        } else {
          sections.add(Section(soup: section, url: url));
        }
      }
    }
  }

  Section getSection(int index) {
    return sections[index];
  }

  Section getOptionalSection(int index) {
    return optionalSections[index];
  }
}

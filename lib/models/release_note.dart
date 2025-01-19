class ReleaseNote {
  final String version;
  final String content;
  final String plainText;

  ReleaseNote({
    required this.version,
    required this.content,
    this.plainText = '',
  });
}

List<String> extractImageUrls(String html) {
  if (html.isEmpty) return <String>[];

  final regex = RegExp(
    r'''src=['"]?(\/\/[^'"\s>]+|https?:\/\/[^'"\s>]+)['"]?''',
    caseSensitive: false,
  );
  final matches = regex.allMatches(html);

  final urls = <String>[];
  final seen = <String>{};

  for (final m in matches) {
    final raw = m.group(1)!;
    final fixed = raw.startsWith('//') ? 'https:$raw' : raw;

    if (seen.add(fixed)) {
      urls.add(fixed);
    }
  }
  return urls;
}

String safeImageUrl(String? raw) {
  if (raw == null) return '';
  final s = raw.trim();
  if (s.isEmpty) return '';

  // لو يبدأ بـ // ضيف https:
  String url = s.startsWith('//')
      ? 'https:$s'
      : (s.startsWith('http') ? s : 'https:$s');

  // تأكد إذا فيه امتداد شائع (.jpg .png .jpeg .webp)
  final hasExt = RegExp(
    r'\.(jpg|jpeg|png|webp|gif)(\?.*)?$',
    caseSensitive: false,
  ).hasMatch(url);
  if (!hasExt) {
    // لو تبي تجربة سريعة: حاول تضيف .jpg (اختياري، قد لا ينجح دائماً)
    // return '$url.jpg';

    // الأفضل: ارجع فارغ لتعرض placeholder بدل ما تضيف و تحاول تحميل رابط ممكن 404
    return '';
  }

  return url;
}

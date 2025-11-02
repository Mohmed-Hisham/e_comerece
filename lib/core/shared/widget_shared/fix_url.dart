String? secureUrl(String? url, {List<String>? allowedDomains}) {
  if (url == null || url.isEmpty) return null;

  try {
    // أضف https لو الرابط ناقص البروتوكول
    if (url.startsWith('//')) {
      url = 'https:$url';
    } else if (!url.startsWith(RegExp(r'https?://'))) {
      // ارفض أي بروتوكول غير http/https
      return null;
    }

    final uri = Uri.parse(url);

    // تحقق أن البروتوكول آمن (https فقط)
    if (uri.scheme != 'https') {
      return null;
    }

    // تحقق من النطاق المسموح به (اختياري)
    if (allowedDomains != null && allowedDomains.isNotEmpty) {
      final host = uri.host.toLowerCase();
      final isAllowed = allowedDomains.any((d) => host.endsWith(d));
      if (!isAllowed) return null;
    }

    return uri.toString();
  } catch (e) {
    // في حال الرابط غير صالح
    return null;
  }
}

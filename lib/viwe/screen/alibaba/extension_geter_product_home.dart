import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';

extension ResultListExtensions on ResultList {
  String get mainImageUrl {
    final img = item?.image;
    if (img == null || img.isEmpty) return '';
    if (img.startsWith('//')) return img;
    if (img.startsWith('http')) return img;
    return img;
  }

  List<String> get imageUrls {
    final imgs = item?.images ?? [];
    return imgs.map((i) {
      if (i.startsWith('//')) return 'https:$i';
      if (i.startsWith('http')) return i;
      return 'https:$i';
    }).toList();
  }

  String get minOrderFormatted {
    try {
      final formatted =
          item?.sku?.def?.quantityModule?.minOrder?.quantityFormatted;
      if (formatted == null || formatted.isEmpty) return '-------';
      return formatted;
    } catch (_) {
      return '-------';
    }
  }

  String get skuPriceFormatted {
    final pf = item?.sku?.def?.priceModule?.priceFormatted;
    if (pf == null || pf.isEmpty) return 'N/A';
    return pf;
  }

  int get itemid => int.tryParse(item?.itemId?.toString() ?? '0') ?? 0;
  String get titel => item?.title ?? '';
}

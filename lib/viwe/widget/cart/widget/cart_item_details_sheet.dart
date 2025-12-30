import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemDetailsSheet {
  static void show(BuildContext context, Map<String, dynamic> attributes) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'productDetails'.tr, // Localized
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ..._buildAttributeWidgets(attributes),
          ],
        ),
      ),
    );
  }

  static String _valueToText(dynamic value) {
    if (value == null) return '';
    if (value is String) return value.trim();
    if (value is num || value is bool) return value.toString();
    if (value is Map) {
      final keys = ['name', 'title', 'model', 'value', 'label', 'text'];
      for (final k in keys) {
        final v = value[k];
        if (v != null && v is String && v.trim().isNotEmpty) return v.trim();
      }
      if (value.length == 1) return value.values.first.toString();
      return value.entries.map((e) => '${e.key}: ${e.value}').join(', ');
    }
    if (value is List) return value.map((e) => _valueToText(e)).join(', ');
    return value.toString();
  }

  static String? _extractImageUrl(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      final candidate = secureUrl(value);
      if (candidate != null) return candidate;
      return null;
    }
    if (value is Map) {
      final imgKeys = [
        'image',
        'img',
        'picture',
        'photo',
        'thumbnail',
        'model',
      ];
      for (final k in imgKeys) {
        final v = value[k];
        if (v is String) {
          final candidate = secureUrl(v);
          if (candidate != null) return candidate;
        }
      }
      final stringRepr = value.toString();
      final candidate = secureUrl(stringRepr);
      if (candidate != null) return candidate;
      return null;
    }
    if (value is List) {
      for (final it in value) {
        final c = _extractImageUrl(it);
        if (c != null) return c;
      }
    }
    return null;
  }

  static List<Widget> _buildAttributeWidgets(Map<String, dynamic>? attributes) {
    if (attributes == null) return [];

    final List<Widget> widgets = [];

    attributes.forEach((rawKey, rawValue) {
      final key = rawKey;
      String displayText = '';
      String? imageUrl;

      if (rawValue is Map<String, dynamic>) {
        displayText = _valueToText(rawValue);
        imageUrl = _extractImageUrl(rawValue);
      } else if (rawValue is List) {
        displayText = rawValue.map((v) => _valueToText(v)).join(', ');
        imageUrl = _extractImageUrl(rawValue);
      } else {
        displayText = _valueToText(rawValue);
        imageUrl = _extractImageUrl(rawValue);
      }

      if (imageUrl == null && rawValue is! Map) {
        final siblingKeys = [
          'image',
          'img',
          'photo',
          'thumbnail',
          'model',
          '${key}_image',
        ];
        for (final s in siblingKeys) {
          if (attributes.containsKey(s)) {
            imageUrl = _extractImageUrl(attributes[s]);
            if (imageUrl != null) break;
          }
        }
      }

      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: '$key: ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: displayText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (c, s) => Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey[200],
                      ),
                      errorWidget: (c, s, e) => Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 18),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });

    return widgets;
  }
}

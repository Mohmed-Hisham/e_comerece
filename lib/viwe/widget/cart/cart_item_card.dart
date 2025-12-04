import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartItemCard extends StatelessWidget {
  final CartModel cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final attributes = jsonDecode(cartItem.cartAttributes!);
    final controller = Get.find<CartControllerImpl>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          final plat = cartItem.cartPlatform!.toLowerCase();
          controller.gotoditels(
            id: plat == "aliexpress" || plat == "alibaba"
                ? int.parse(cartItem.productId!)
                : cartItem.productId!,
            lang: plat == "amazon" ? enOrArAmazon() : enOrAr(),
            title: cartItem.cartProductTitle!,
            asin: cartItem.productId ?? "",
            goodssn: cartItem.goodsSn ?? "",
            goodsid: cartItem.productId ?? "",
            categoryid: cartItem.categoryId ?? "",
            platform: cartItem.cartPlatform!.toLowerCase(),
          );
        },
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: secureUrl(cartItem.cartProductImage) ?? '',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Loadingimage(),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
                Positioned(
                  height: 30,
                  width: 30,
                  top: -5,
                  left: -5,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Appcolor.somgray,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      alignment: Alignment.center,
                      iconSize: 15,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Appcolor.primrycolor,
                      ),
                      onPressed: () {
                        controller.removeItem(cartItem.cartId!);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.cartProductTitle!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        cartItem.cartPrice!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "asian",
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          _showProductDetails(context, attributes);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Appcolor.gray),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "more",
                            style: TextStyle(
                              height: 1.1,
                              color: Appcolor.primrycolor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GetBuilder<CartControllerImpl>(
              id: "1",
              builder: (addRemoveController) => Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Appcolor.somgray,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        addRemoveController.addprise(cartModel: cartItem);
                      },
                      icon: FaIcon(FontAwesomeIcons.plus, size: 20),
                    ),
                  ),
                  Text(
                    '  ${cartItem.cartQuantity}  ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Appcolor.black,
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Appcolor.somgray,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        addRemoveController.removprise(cartModel: cartItem);
                      },
                      icon: FaIcon(FontAwesomeIcons.minus, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(
    BuildContext context,
    Map<String, dynamic> attributes,
  ) {
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
            const Text(
              'Product Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...buildAttributeWidgets(attributes),
          ],
        ),
      ),
    );
  }

  String _valueToText(dynamic value) {
    if (value == null) return '';
    if (value is String) return value.trim();
    if (value is num || value is bool) return value.toString();
    if (value is Map) {
      // حاول استخراج اسم من مفاتيح شائعة
      final keys = ['name', 'title', 'model', 'value', 'label', 'text'];
      for (final k in keys) {
        final v = value[k];
        if (v != null && v is String && v.trim().isNotEmpty) return v.trim();
      }
      // لو فيه زوج key/value داخل الماب، حاول تحويله لنص
      if (value.length == 1) return value.values.first.toString();
      return value.entries.map((e) => '${e.key}: ${e.value}').join(', ');
    }
    if (value is List) return value.map((e) => _valueToText(e)).join(', ');
    return value.toString();
  }

  String? _extractImageUrl(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      final candidate = secureUrl(value);
      if (candidate != null) return candidate;
      return null;
    }
    if (value is Map) {
      // مفاتيح محتملة تحوي صورة
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
      // لو الماب نفسها عبارة عن رابط
      final stringRepr = value.toString();
      final candidate = secureUrl(stringRepr);
      if (candidate != null) return candidate;
      return null;
    }
    if (value is List) {
      // خذ أول رابط صالح في الليست لو موجود
      for (final it in value) {
        final c = _extractImageUrl(it);
        if (c != null) return c;
      }
    }
    return null;
  }

  List<Widget> buildAttributeWidgets(
    Map<String, dynamic>? attributes, {
    List<String>? allowedDomains,
  }) {
    if (attributes == null) return [];

    final List<Widget> widgets = [];

    attributes.forEach((rawKey, rawValue) {
      final key = rawKey;
      // نص العرض: نحاول بناء نص لطيف من القيمة
      String displayText = '';
      String? imageUrl;

      // بعض المصادر تضع القيم في شكل Map داخل map e.g. "Color": {"name": "Rose", "image": "..."}
      if (rawValue is Map<String, dynamic>) {
        displayText = _valueToText(rawValue);
        imageUrl = _extractImageUrl(rawValue);
      } else if (rawValue is List) {
        // لو لستة من القيم، حولها إلى نص وجرب إيجاد صورة
        displayText = rawValue.map((v) => _valueToText(v)).join(', ');
        imageUrl = _extractImageUrl(rawValue);
      } else {
        // قيمة بسيطة (String/num/bool)
        displayText = _valueToText(rawValue);
        // أحيانًا يكون الـ key يحمل رابط (rare) أو القيمة نفسها رابط
        imageUrl = _extractImageUrl(rawValue);
      }

      // لو ما لاقيش صورة بعد دا كله، ممكن تكون في مفتاح موازي مثل "model" أو "image" بجانب key
      if (imageUrl == null && rawValue is! Map) {
        // مثال: بعض الـ payloads يحطون صورة كمفتاح مجاور داخل نفس attributes map
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

      // فلترة دومينات لو عايز (اختياري)
      if (allowedDomains != null &&
          allowedDomains.isNotEmpty &&
          imageUrl != null) {
        final host = Uri.tryParse(imageUrl)?.host ?? '';
        final ok = allowedDomains.any((d) => host.endsWith(d));
        if (!ok) imageUrl = null;
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

import 'dart:convert';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/data/model/ordres/get_order_with_id_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderDetailProductItem extends StatelessWidget {
  final Item item;

  const OrderDetailProductItem({super.key, required this.item});

  Map<String, dynamic>? _parseAttributes() {
    try {
      if (item.attributes == null) return null;
      // Remove extra quotes and parse
      String cleaned = item.attributes!.replaceAll(r'\/', '/');
      return jsonDecode(jsonDecode(cleaned));
    } catch (e) {
      return null;
    }
  }

  String _getImageUrl(String? image) {
    if (image == null || image.isEmpty) return '';
    if (image.startsWith('http')) return image;
    return 'https:$image';
  }

  @override
  Widget build(BuildContext context) {
    final attributes = _parseAttributes();
    final imageUrl = _getImageUrl(item.productImage);
    final price = double.tryParse(item.productPrice ?? '0') ?? 0;
    final total = price * (item.quantity ?? 1);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.gray.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Appcolor.gray.withValues(alpha: 0.1),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Appcolor.primrycolor,
                    strokeWidth: 2,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Appcolor.gray.withValues(alpha: 0.1),
                child: Icon(
                  Icons.image_not_supported,
                  color: Appcolor.gray,
                  size: 30.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  item.productTitle ?? 'منتج',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),

                // Platform Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getPlatformColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.productPlatform?.toUpperCase() ?? 'PLATFORM',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: _getPlatformColor(),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                // Attributes
                if (attributes != null) ...[
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: attributes.entries.map((entry) {
                      final value = entry.value;
                      final name = value is Map
                          ? value['name']
                          : value.toString();
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Appcolor.gray.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${entry.key}: $name',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Appcolor.gray,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 8.h),
                ],

                // Price and Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'الكمية: ',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Appcolor.gray,
                          ),
                        ),
                        Text(
                          '${item.quantity ?? 1}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.primrycolor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.primrycolor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPlatformColor() {
    switch (item.productPlatform?.toLowerCase()) {
      case 'aliexpress':
        return const Color(0xFFE62E04);
      case 'amazon':
        return const Color(0xFFFF9900);
      case 'shein':
        return const Color(0xFF000000);
      case 'alibaba':
        return const Color(0xFFFF6A00);
      default:
        return Appcolor.primrycolor;
    }
  }
}

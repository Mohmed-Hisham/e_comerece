import 'dart:convert';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/data/model/ordres/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailProductItem extends StatelessWidget {
  final OrderDetailsItem item;

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

  @override
  Widget build(BuildContext context) {
    final attributes = _parseAttributes();
    final price = item.productPrice ?? 0.0;
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
          CustomCachedImage(
            imageUrl: item.productImage ?? '',
            width: 80.w,
            height: 80.w,
          ),

          SizedBox(width: 12.w),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  item.productTitle ?? StringsKeys.product.tr,
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
                    item.platform?.toUpperCase() ?? StringsKeys.platform.tr,
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
                          '${StringsKeys.quantity.tr}: ',
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
    switch (item.platform?.toLowerCase()) {
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

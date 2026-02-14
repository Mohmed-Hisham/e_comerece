import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/format_date.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/data/model/ordres/get_order_with_status_model.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final Orders order;
  const OrderCard({super.key, required this.order});

  CurrencyService get _cs => Get.find<CurrencyService>();

  String _formatAmount(double? amount) {
    if (amount == null) return _cs.convertAndFormat(amount: 0, from: 'USD');
    return _cs.convertAndFormat(amount: amount, from: 'USD');
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFE5A100);
      case 'ActionRequired':
        return const Color(0xFFE53935);
      case 'Processing':
        return const Color(0xFF7B1FA2);
      case 'Shipped':
        return const Color(0xFF0288D1);
      case 'Completed':
        return const Color(0xFF2E7D32);
      case 'Cancelled':
        return const Color(0xFF757575);
      default:
        return Appcolor.primrycolor;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'Pending':
        return Icons.hourglass_top_rounded;
      case 'ActionRequired':
        return Icons.notification_important_rounded;
      case 'Processing':
        return Icons.settings_rounded;
      case 'Shipped':
        return Icons.local_shipping_rounded;
      case 'Completed':
        return Icons.check_circle_rounded;
      case 'Cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _getStatusLabel(String? status) {
    switch (status) {
      case 'Pending':
        return StringsKeys.orderStatusPending.tr;
      case 'ActionRequired':
        return StringsKeys.orderStatusActionRequired.tr;
      case 'Processing':
        return StringsKeys.orderStatusProcessing.tr;
      case 'Shipped':
        return StringsKeys.orderStatusShipped.tr;
      case 'Completed':
        return StringsKeys.orderStatusCompleted.tr;
      case 'Cancelled':
        return StringsKeys.orderStatusCancelled.tr;
      default:
        return status ?? 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.status);

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutesname.orderDetails,
          arguments: {'order_id': order.id},
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(200),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Left status accent bar
              Container(
                width: 4.w,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    bottomLeft: Radius.circular(14.r),
                  ),
                ),
              ),
              // Card content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // -- Header row: order number + status chip --
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  '#${order.orderNumber ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Appcolor.black,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                if (order.createdAt != null)
                                  Text(
                                    custformatDate(order.createdAt!),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Appcolor.gray,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getStatusIcon(order.status),
                                  size: 13.sp,
                                  color: statusColor,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  _getStatusLabel(order.status),
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // -- Product images + items count + total --
                      Row(
                        children: [
                          if (order.items != null &&
                              order.items!.productImages.isNotEmpty)
                            _buildStackedImages(order.items!.productImages),
                          if (order.items != null &&
                              order.items!.productImages.isNotEmpty)
                            SizedBox(width: 12.w),
                          // Items count
                          if (order.items != null)
                            Text(
                              "${order.items!.itemsCount} ${StringsKeys.product.tr}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Appcolor.black2,
                              ),
                            ),
                          const Spacer(),
                          // Total
                          Text(
                            _formatAmount(order.total),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Appcolor.primrycolor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // -- Footer: payment method + arrow --
                      Row(
                        children: [
                          Icon(
                            Icons.payment_rounded,
                            size: 14.sp,
                            color: Appcolor.gray,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              order.paymentMethod ?? 'N/A',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Appcolor.gray,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14.sp,
                            color: Appcolor.gray,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStackedImages(List<ProductImage> images) {
    const double size = 38.0;
    const int maxVisible = 3;
    final int displayCount = images.length > maxVisible
        ? maxVisible
        : images.length;
    final int remaining = images.length - displayCount;

    return SizedBox(
      height: size.h,
      width: (size + (displayCount - 1) * 22 + (remaining > 0 ? 22 : 0)).w,
      child: Stack(
        children: [
          ...List.generate(displayCount, (index) {
            return Positioned(
              left: (index * 22).w,
              child: Container(
                height: size.h,
                width: size.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: CachedNetworkImage(
                    imageUrl: secureUrl(images[index].productImage) ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Loadingimage(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.image_not_supported, size: 16.sp),
                  ),
                ),
              ),
            );
          }),
          if (remaining > 0)
            Positioned(
              left: (displayCount * 22).w,
              child: Container(
                height: size.h,
                width: size.h,
                decoration: BoxDecoration(
                  color: Appcolor.primrycolor.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.primrycolor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

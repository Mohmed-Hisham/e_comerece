import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/format_date.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/data/model/ordres/get_order_with_status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final Orders order;
  const OrderCard({super.key, required this.order});

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'PendingReview':
        return Appcolor.threecolor;
      case 'AdminNotes':
        return Appcolor.reed;
      case 'Approved':
        return const Color(0xff4CAF50);
      case 'AwaitingPayment':
        return Colors.orange;
      case 'Paid':
        return Colors.blue;
      case 'Processing':
        return Colors.purple;
      case 'InTransit':
        return Colors.cyan;
      case 'Completed':
        return const Color(0xff2E7D32);
      case 'Cancelled':
        return Appcolor.gray;
      default:
        return Appcolor.primrycolor;
    }
  }

  String _getStatusLabel(String? status) {
    switch (status) {
      case 'PendingReview':
        return 'Pending Review';
      case 'AdminNotes':
        return 'Admin Notes';
      case 'Approved':
        return 'Approved';
      case 'AwaitingPayment':
        return 'Awaiting Payment';
      case 'Paid':
        return 'Paid';
      case 'Processing':
        return 'Processing';
      case 'InTransit':
        return 'In Transit';
      case 'Completed':
        return 'Completed';
      case 'Cancelled':
        return 'Cancelled';
      default:
        return status ?? 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutesname.orderDetails,
          arguments: {'order_id': order.id},
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Appcolor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Appcolor.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Order Number and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: Appcolor.primrycolor,
                        size: 24.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '#${order.orderNumber ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                        order.status,
                      ).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(order.status),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      _getStatusLabel(order.status),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(order.status),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Items View (Stacked Images and Count)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (order.items != null &&
                      order.items!.productImages.isNotEmpty)
                    _buildStackedImages(order.items!.productImages),
                  if (order.items != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Appcolor.gray.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${order.items!.itemsCount} Items",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Appcolor.black2,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16.h),

              // Divider
              Divider(color: Appcolor.gray.withValues(alpha: 0.3), height: 1),
              SizedBox(height: 16.h),

              // Amount Details
              _buildAmountRow('Subtotal:', order.subtotal, isSubtotal: true),
              SizedBox(height: 8.h),

              if (order.couponDiscount != null &&
                  order.couponDiscount! > 0) ...[
                _buildAmountRow(
                  'Discount:',
                  order.couponDiscount,
                  isDiscount: true,
                ),
                SizedBox(height: 8.h),
              ],

              if (order.productReviewFee != null &&
                  order.productReviewFee! > 0) ...[
                _buildAmountRow('Review Fee:', order.productReviewFee),
                SizedBox(height: 8.h),
              ],

              // Divider
              Divider(color: Appcolor.gray.withValues(alpha: 0.3), height: 1),
              SizedBox(height: 12.h),

              // Total Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.black,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.primrycolor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\$${order.total?.toStringAsFixed(2) ?? '0.00'}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.primrycolor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Footer: Payment Method and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.payment, size: 16.sp, color: Appcolor.gray),
                      SizedBox(width: 6.w),
                      Text(
                        order.paymentMethod ?? 'N/A',
                        style: TextStyle(fontSize: 13.sp, color: Appcolor.gray),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.sp,
                        color: Appcolor.gray,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        order.createdAt != null
                            ? custformatDate(order.createdAt!)
                            : 'N/A',
                        style: TextStyle(fontSize: 13.sp, color: Appcolor.gray),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStackedImages(List<ProductImage> images) {
    const double size = 45.0;
    const int maxVisible = 4;
    final int displayCount = images.length > maxVisible
        ? maxVisible
        : images.length;

    return SizedBox(
      height: size.h,
      width: (size + (displayCount - 1) * 20).w,
      child: Stack(
        children: List.generate(displayCount, (index) {
          return Positioned(
            left: (index * 20).w,
            child: Container(
              height: size.h,
              width: size.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: secureUrl(images[index].productImage) ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Loadingimage(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAmountRow(
    String label,
    double? amount, {
    bool isSubtotal = false,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: Appcolor.black2),
        ),
        Text(
          isDiscount
              ? '-\$${amount?.toStringAsFixed(2) ?? '0.00'}'
              : '\$${amount?.toStringAsFixed(2) ?? '0.00'}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isSubtotal ? FontWeight.w500 : FontWeight.normal,
            color: isDiscount ? Appcolor.reed : Appcolor.black2,
          ),
        ),
      ],
    );
  }
}

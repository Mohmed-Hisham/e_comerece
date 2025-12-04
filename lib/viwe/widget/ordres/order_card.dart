import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/format_date.dart';
import 'package:e_comerece/data/model/ordres/get_order_with_status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final Orders order;
  const OrderCard({super.key, required this.order});
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_approval':
        return Appcolor.threecolor;
      case 'approved':
        return const Color(0xff4CAF50);
      case 'rejected':
        return Appcolor.reed;
      case 'ordered':
        return const Color(0xff2196F3);
      case 'completed':
        return const Color(0xff2E7D32);
      case 'cancelled':
        return Appcolor.gray;
      default:
        return Appcolor.primrycolor;
    }
  }

  String _getStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_approval':
        return StringsKeys.orderStatusPendingApproval.tr;
      case 'approved':
        return StringsKeys.orderStatusApproved.tr;
      case 'rejected':
        return StringsKeys.orderStatusRejected.tr;
      case 'ordered':
        return StringsKeys.orderStatusOrdered.tr;
      case 'completed':
        return StringsKeys.orderStatusCompleted.tr;
      case 'cancelled':
        return StringsKeys.orderStatusCancelled.tr;
      default:
        return status ?? StringsKeys.unknownStatus.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutesname.orderDetails,
          arguments: {'order_id': order.orderId},
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
              // Header: Order ID and Status
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
                        '${StringsKeys.orderPrefix.tr} #${order.orderId ?? 'N/A'}',
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
                      ).withValues(alpha: 0.5),
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

              // Divider
              Divider(color: Appcolor.gray.withValues(alpha: 0.3), height: 1),
              SizedBox(height: 16.h),

              // Amount Details
              _buildAmountRow(
                '${StringsKeys.subtotal.tr}:',
                order.subtotal,
                isSubtotal: true,
              ),
              SizedBox(height: 8.h),

              if (order.discountAmount != null &&
                  order.discountAmount! > 0) ...[
                _buildAmountRow(
                  '${StringsKeys.discount.tr}:',
                  order.discountAmount?.toDouble(),
                  isDiscount: true,
                ),
                SizedBox(height: 8.h),
              ],

              _buildAmountRow(
                '${StringsKeys.shipping.tr}:',
                order.shippingAmount?.toDouble(),
                isSubtotal: true,
              ),
              SizedBox(height: 12.h),

              // Divider
              Divider(color: Appcolor.gray.withValues(alpha: 0.3), height: 1),
              SizedBox(height: 12.h),

              // Total Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${StringsKeys.totalAmount.tr}:',
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
                      '\$${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
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

              // Footer: Payment Status and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.payment, size: 16.sp, color: Appcolor.gray),
                      SizedBox(width: 6.w),
                      Text(
                        order.paymentStatus ?? StringsKeys.unknownStatus.tr,
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
                        custformatDate(order.createdAt!),
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

import 'package:e_comerece/controller/local_service/local_service_order_details_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/ordres/order_tracking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class LocalServiceOrderDetailsView extends StatelessWidget {
  const LocalServiceOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocalServiceOrderDetailsController());
    return Scaffold(
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          SafeArea(
            child: Column(
              children: [
                PositionedAppBar(
                  title: 'تفاصيل الطلب',
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: GetBuilder<LocalServiceOrderDetailsController>(
                    builder: (controller) {
                      return Handlingdataviwe(
                        statusrequest: controller.statusrequest,
                        widget:
                            controller.statusrequest == Statusrequest.success
                            ? _buildOrderDetails(controller)
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(LocalServiceOrderDetailsController controller) {
    final order = controller.orderDetails.data!.order!;
    final service = controller.orderDetails.data!.service!;
    final address = controller.orderDetails.data!.address!;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Tracking Widget
          OrderTrackingWidget(
            currentStatus: order.status ?? 'pending_approval',
          ),
          SizedBox(height: 20.h),

          // Order Summary Card
          _buildSectionCard(
            title: 'معلومات الطلب',
            icon: Icons.receipt_long,
            children: [
              _buildInfoRow('رقم الطلب', '#${order.orderId ?? 'N/A'}'),
              _buildDivider(),
              _buildInfoRow(
                'تاريخ الطلب',
                order.createAt != null
                    ? Jiffy.parse(
                        order.createAt.toString(),
                      ).format(pattern: 'yyyy-MM-dd HH:mm')
                    : 'غير متوفر',
              ),
              _buildDivider(),
              _buildInfoRow(
                'حالة الطلب',
                _getStatusLabel(order.status),
                valueColor: _getStatusColor(order.status),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Service Info Card
          _buildSectionCard(
            title: 'تفاصيل الخدمة',
            icon: Icons.design_services,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: SizedBox(
                      width: 60.w,
                      height: 60.h,
                      child: CustomCachedImage(imageUrl: service.image!),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.name ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${service.price} \$',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.primrycolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Address Card
          _buildSectionCard(
            title: 'عنوان التوصيل',
            icon: Icons.location_on,
            children: [
              _buildInfoRow('العنوان', address.title ?? 'غير متوفر'),
              _buildDivider(),
              _buildInfoRow('المدينة', address.city ?? 'غير متوفر'),
              _buildDivider(),
              _buildInfoRow('الشارع', address.street ?? 'غير متوفر'),
              _buildDivider(),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(
                      'المبنى',
                      address.buildingNumber ?? '-',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildInfoRow('الطابق', address.floor ?? '-'),
                  ),
                ],
              ),
              _buildDivider(),
              _buildInfoRow('الشقة', address.apartment ?? 'غير متوفر'),
              _buildDivider(),
              _buildInfoRow('رقم الهاتف', address.phone ?? 'غير متوفر'),
            ],
          ),
          SizedBox(height: 16.h),

          // Note Card (if exists)
          if (order.note != null && order.note!.isNotEmpty) ...[
            _buildSectionCard(
              title: 'ملاحظات',
              icon: Icons.note,
              children: [
                Text(
                  order.note!,
                  style: TextStyle(fontSize: 14.sp, color: Appcolor.black),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],

          // Cancel Order Button
          if (controller.orderDetails.data?.order != null)
            BuildCancelButton(controller: controller),
        ],
      ),
    );
  }

  //  class buildCancelButton(LocalServiceOrderDetailsController controller) {
  //   final orderStatus = controller.orderDetails.data!.order!.status;
  //   final isCancelable =
  //       orderStatus == 'pending_approval' || orderStatus == 'approved';

  //   return Container(
  //     width: double.infinity,
  //     margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: isCancelable ? Appcolor.reed : Appcolor.gray,
  //         padding: EdgeInsets.symmetric(vertical: 12.h),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12.r),
  //         ),
  //       ),
  //       onPressed: () {
  //         if (isCancelable) {
  //           Get.defaultDialog(
  //             title: "تأكيد الإلغاء",
  //             middleText: "هل أنت متأكد من رغبتك في إلغاء هذا الطلب؟",
  //             textConfirm: "نعم",
  //             textCancel: "لا",
  //             confirmTextColor: Colors.white,
  //             buttonColor: Appcolor.reed,
  //             onConfirm: () {
  //               Get.back(); // Check 'middleText' dialog
  //               controller.cancelOrder();
  //             },
  //           );
  //         } else {
  //           showCustomGetSnack(
  //             isGreen: false,
  //             text: "لا يمكن إلغاء الطلب في حالته الحالية",
  //           );
  //         }
  //       },
  //       child: Text(
  //         "إلغاء الطلب",
  //         style: TextStyle(
  //           fontSize: 16.sp,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appcolor.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Appcolor.primrycolor.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Appcolor.primrycolor, size: 24.sp),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.black,
                  ),
                ),
              ],
            ),
          ),

          // Section Content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Appcolor.gray),
          ),
          SizedBox(width: 12.w),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Appcolor.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Divider(color: Appcolor.gray.withValues(alpha: 0.2), height: 1),
    );
  }

  String _getStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_approval':
        return 'قيد المراجعة';
      case 'approved':
        return 'تم الموافقة';
      case 'rejected':
        return 'مرفوض';
      case 'ordered':
        return 'تم الطلب';
      case 'completed':
        return 'مكتمل';
      case 'cancelled':
        return 'ملغي';
      case 'declined':
        return 'مرفوض';
      case 'processing': // Added for robustness based on previous file
        return 'قيد التنفيذ';
      default:
        return status ?? 'غير معروف';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_approval':
        return Appcolor.threecolor; // Orange
      case 'approved':
        return const Color(0xff4CAF50); // Green
      case 'rejected':
      case 'declined':
        return Appcolor.reed; // Red
      case 'ordered':
        return const Color(0xff2196F3); // Blue
      case 'completed':
        return const Color(0xff2E7D32); // Dark Green
      case 'cancelled':
        return Appcolor.gray;
      case 'processing':
        return Colors.indigo;
      default:
        return Appcolor.primrycolor;
    }
  }
}

class BuildCancelButton extends StatelessWidget {
  final LocalServiceOrderDetailsController controller;
  const BuildCancelButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final orderStatus = controller.orderDetails.data!.order!.status;
    final isCancelable =
        orderStatus == 'pending_approval' ||
        orderStatus == 'approved' ||
        orderStatus == 'Pending';

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isCancelable ? Appcolor.reed : Appcolor.gray,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: () {
          if (isCancelable) {
            Get.defaultDialog(
              title: "تأكيد الإلغاء",
              middleText: "هل أنت متأكد من رغبتك في إلغاء هذا الطلب؟",
              textConfirm: "نعم",
              textCancel: "لا",
              confirmTextColor: Colors.white,
              buttonColor: Appcolor.reed,
              onConfirm: () {
                Get.back(); // Check 'middleText' dialog
                controller.cancelOrder();
              },
            );
          } else {
            showCustomContextSnack(
              context: context,
              isGreen: false,
              text: "لا يمكن إلغاء الطلب في حالته الحالية",
            );
          }
        },
        child: Text(
          "إلغاء الطلب",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

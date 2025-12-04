import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/local_service_order_details_view.dart';
import 'package:e_comerece/data/model/local_service/get_order_local_service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class LocalServiceOrderCard extends StatelessWidget {
  final Order order;

  const LocalServiceOrderCard({super.key, required this.order});

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_approval':
        return Appcolor.threecolor;
      case 'approved':
        return const Color(0xff4CAF50);
      case 'rejected':
      case 'declined':
        return Appcolor.reed;
      case 'ordered':
        return const Color(0xff2196F3);
      case 'completed':
        return const Color(0xff2E7D32);
      case 'cancelled':
        return Appcolor.gray;
      case 'processing':
        return Colors.indigo;
      default:
        return Appcolor.primrycolor;
    }
  }

  String _getStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_approval':
        return 'قيد المراجعة';
      case 'approved':
        return 'تم الموافقة';
      case 'rejected':
      case 'declined':
        return 'مرفوض';
      case 'ordered':
        return 'تم الطلب';
      case 'completed':
        return 'مكتمل';
      case 'cancelled':
        return 'ملغي';
      case 'processing':
        return 'قيد التنفيذ';
      default:
        return status ?? 'غير معروف';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutesname.localServiceOrderDetailsView,
          arguments: {"order_id": order.ordersServicesId},
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Appcolor.white,
          borderRadius: BorderRadius.circular(16.r),
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
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Appcolor.primrycolor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.receipt_long_rounded,
                          color: Appcolor.primrycolor,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '#${order.ordersServicesId ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 16.sp,
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
                        order.orderStatus,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: _getStatusColor(
                          order.orderStatus,
                        ).withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      _getStatusLabel(order.orderStatus),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(order.orderStatus),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Divider(
                  color: Appcolor.gray.withValues(alpha: 0.1),
                  height: 1,
                ),
              ),

              // Service Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      width: 80.w,
                      height: 80.h,
                      child: order.serviceImage != null
                          ? CustomCachedImage(imageUrl: order.serviceImage!)
                          : Container(
                              color: Appcolor.gray.withValues(alpha: 0.1),
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Appcolor.gray,
                                size: 30.sp,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.serviceName ?? 'Unknown Service',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.black,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        if (order.serviceCity != null)
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14.sp,
                                color: Appcolor.gray,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  order.serviceCity!,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Appcolor.gray,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 6.h),
                        if (order.orderCreateAt != null)
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14.sp,
                                color: Appcolor.gray,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                Jiffy.parse(
                                  order.orderCreateAt.toString(),
                                ).fromNow(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Appcolor.gray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class LocalServiceOrderCard extends StatelessWidget {
  final ServiceRequestData order;

  const LocalServiceOrderCard({super.key, required this.order});

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'new':
        return Appcolor.threecolor;
      case 'price_quoted':
        return const Color(0xff2196F3);
      case 'approved':
        return const Color(0xff4CAF50);
      case 'rejected':
      case 'declined':
        return Appcolor.reed;
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
      case 'new':
        return StringsKeys.statusNew.tr;
      case 'price_quoted':
        return StringsKeys.priceSet.tr;
      case 'approved':
        return StringsKeys.statusApproved.tr;
      case 'rejected':
      case 'declined':
        return StringsKeys.statusRejected.tr;
      case 'completed':
        return StringsKeys.statusCompleted.tr;
      case 'cancelled':
        return StringsKeys.statusCancelled.tr;
      default:
        return status ?? StringsKeys.statusUnknown.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutesname.localServiceOrderDetailsView,
          arguments: {"service_request": order},
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
                        '#${""}',
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
                        order.status,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: _getStatusColor(
                          order.status,
                        ).withValues(alpha: 0.2),
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
                                Icons.design_services_outlined,
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
                          'Service Request #${order.serviceName ?? '?'}',
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
                        if (order.quotedPrice != null)
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on_outlined,
                                size: 14.sp,
                                color: Appcolor.gray,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  "${order.quotedPrice}",
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
                        if (order.createdAt != null)
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
                                  order.createdAt.toString(),
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

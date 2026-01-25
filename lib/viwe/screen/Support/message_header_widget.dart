import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ServiceRequestHeader extends StatefulWidget {
  final ServiceRequestDetailData request;
  const ServiceRequestHeader({super.key, required this.request});

  @override
  State<ServiceRequestHeader> createState() => _ServiceRequestHeaderState();
}

class _ServiceRequestHeaderState extends State<ServiceRequestHeader> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Appcolor.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Appcolor.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
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
                    Icons.receipt_long,
                    color: Appcolor.primrycolor,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringsKeys.serviceAmendment.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.request.service?.name ??
                            StringsKeys.unknownService.tr,
                        style: TextStyle(fontSize: 14.sp, color: Appcolor.gray),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Appcolor.gray,
                ),
              ],
            ),
            if (isExpanded) ...[
              SizedBox(height: 12.h),
              Divider(color: Appcolor.gray.withValues(alpha: 0.2)),
              SizedBox(height: 8.h),
              _buildDetailRow(
                StringsKeys.quotedPrice.tr,
                "${widget.request.quotedPrice ?? StringsKeys.notAvailable.tr} \$",
                icon: Icons.attach_money,
              ),
              _buildDetailRow(
                StringsKeys.date.tr,
                widget.request.createdAt != null
                    ? Jiffy.parse(
                        widget.request.createdAt!.toIso8601String(),
                      ).format(pattern: 'yyyy-MM-dd')
                    : StringsKeys.notAvailable.tr,
                icon: Icons.calendar_today,
              ),
              if (widget.request.address != null)
                _buildDetailRow(
                  StringsKeys.addressLabel.tr,
                  "${widget.request.address?.city ?? ''}, ${widget.request.address?.title ?? ''}",
                  icon: Icons.location_on,
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {required IconData icon}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: Appcolor.gray),
          SizedBox(width: 8.w),
          Text(
            "$label:",
            style: TextStyle(fontSize: 12.sp, color: Appcolor.gray),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Appcolor.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceInfoCard extends StatelessWidget {
  final Service service;
  final String? quotedPrice;

  const ServiceInfoCard({super.key, required this.service, this.quotedPrice});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
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
                child: service.image != null
                    ? CustomCachedImage(imageUrl: service.image!)
                    : Container(
                        color: Appcolor.gray.withValues(alpha: 0.1),
                        child: Icon(
                          Icons.design_services,
                          color: Appcolor.primrycolor,
                        ),
                      ),
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
                    '${quotedPrice ?? '??'} \$',
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
    );
  }
}

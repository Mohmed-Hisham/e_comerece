import 'package:e_comerece/controller/local_service/local_service_details_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDetailsContent extends StatelessWidget {
  final LocalServiceDetailsController controller;

  const ServiceDetailsContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 280.h), // Space for the image
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 350.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      width: 50.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Title and Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          controller.service.serviceName!,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Appcolor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp,
                              ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "${controller.service.servicePrice} \$",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Appcolor.primrycolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),

                  // Location
                  if (controller.service.serviceCity != null)
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Appcolor.primrycolor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Appcolor.primrycolor,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          controller.service.serviceCity!,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Divider(color: Colors.grey[200], thickness: 1),
                  ),

                  // Description Title
                  Text(
                    "About Service",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Appcolor.black,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Description Text
                  Text(
                    controller.service.serviceDesc!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      height: 1.6,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

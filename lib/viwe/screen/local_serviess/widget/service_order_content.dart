import 'package:e_comerece/controller/local_service/service_order_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/screen/Address/botton_sheet_location.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceOrderContent extends StatelessWidget {
  const ServiceOrderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceOrderController>(
      builder: (controller) => Positioned.fill(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 300.h),
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 300.h,
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

                  // Service Name & Agreed Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          controller.service.serviceName ?? "",
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Appcolor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                              ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Agreed Price",
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                          Text(
                            "${controller.quotedPrice} \$",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Appcolor.primrycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),

                  // About Service
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    controller.service.serviceDesc ?? "",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Divider(thickness: 1, color: Colors.grey[200]),
                  SizedBox(height: 20.h),

                  // Note Field
                  Text(
                    "Notes",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: controller.noteController,
                    decoration: InputDecoration(
                      hintText: "Add any special instructions...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Appcolor.primrycolor),
                      ),
                      contentPadding: EdgeInsets.all(15.r),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 20.h),

                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 300.h,
                    child: BottonSheetLocation(
                      physics: const BouncingScrollPhysics(),
                      maxHeight: 500,
                      showButtonBack: false,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Custombuttonauth(
                    inputtext: "Confirm & Order",
                    onPressed:
                        (controller.statusRequest == Statusrequest.loading ||
                            controller.statusRequest == Statusrequest.success)
                        ? null
                        : () => controller.confirmOrder(),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

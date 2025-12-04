import 'package:e_comerece/controller/local_service/service_order_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/viwe/screen/Address/botton_sheet_location.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceOrderScreen extends StatelessWidget {
  const ServiceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceOrderController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: GetBuilder<ServiceOrderController>(
        builder: (controller) => Stack(
          children: [
            // 1. Header Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 350.h,
              child: Hero(
                tag: controller.service.serviceId ?? "service_image",
                child: CustomCachedImage(
                  radius: 0,
                  imageUrl:
                      "https://res.cloudinary.com/dgonvbimk/image/upload/v1766790189/pg0ne5gqx5hwyk7uyxhj.jpg",
                ),
              ),
            ),

            // 2. Scrollable Content
            Positioned.fill(
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 25.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag Handle
                        Center(
                          child: Container(
                            width: 50.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
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
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                                Text(
                                  "${controller.quotedPrice} \$",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
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
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          controller.service.serviceDesc ?? "",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600], height: 1.5),
                        ),
                        SizedBox(height: 20.h),
                        Divider(thickness: 1, color: Colors.grey[200]),
                        SizedBox(height: 20.h),

                        // Note Field
                        Text(
                          "Notes",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
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
                              borderSide: BorderSide(
                                color: Appcolor.primrycolor,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(15.r),
                          ),
                          maxLines: 3,
                        ),
                        SizedBox(height: 20.h),

                        // Address Selection
                        Text(
                          "Location",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 300.h,
                          child: BottonSheetLocation(
                            physics:
                                const BouncingScrollPhysics(), // Handle scrolling in main list
                            maxHeight: 500,
                            showButtonBack: false,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Confirm Button
                        if (controller.statusRequest == Statusrequest.loading)
                          const Center(child: CircularProgressIndicator())
                        else
                          Custombuttonauth(
                            inputtext: "Confirm & Order",
                            onPressed: () => controller.confirmOrder(),
                          ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

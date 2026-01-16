import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/about_us_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/widget/Positioned/Positioned_left_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AboutUsControllerImpl());

    return Scaffold(
      body: GetBuilder<AboutUsControllerImpl>(
        builder: (controller) => Stack(
          children: [
            PositionedLeft1(),
            PositionedRight3(),
            // Positioned(
            //   top: 65.h,
            //   left: 15.w,
            //   child: SizedBox(
            //     height: 210.h,
            //     width: 210.w,
            //     child: Customtexttitleauth(text: StringsKeys.aboutUs.tr),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: 100.h),
              child: Handlingdataviwe(
                statusrequest: controller.statusrequest,
                ontryagain: () => controller.getData(),
                shimmer: _buildShimmer(),
                widget: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  itemCount: controller.aboutUsData.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h),
                  itemBuilder: (context, index) {
                    final item = controller.aboutUsData[index];
                    return _buildCard(item);
                  },
                ),
              ),
            ),
            PositionedAppBar(
              title: StringsKeys.aboutUs.tr,
              onPressed: Get.back,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(item) {
    return Card(
      color: Colors.white.withOpacity(0.7),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              item.title ?? "",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.primrycolor,
              ),
            ),
            SizedBox(height: 12.h),

            // Image (if available)
            if (item.image != null && item.image!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: item.image!,
                  width: double.infinity,
                  height: 180.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 180.h,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 180.h,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            if (item.image != null && item.image!.isNotEmpty)
              SizedBox(height: 12.h),

            // Body
            Text(
              item.body ?? "",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                height: 1.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Container(
                    height: 24.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Image shimmer
                  Container(
                    height: 180.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Body shimmer lines
                  Container(
                    height: 14.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 14.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 14.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

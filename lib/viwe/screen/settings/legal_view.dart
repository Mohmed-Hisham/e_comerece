import 'package:e_comerece/controller/settings/legal_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/data/model/legal_model.dart';
import 'package:e_comerece/viwe/widget/Positioned/Positioned_left_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LegalView extends StatelessWidget {
  final String title;
  const LegalView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Get.put(LegalControllerImpl());
    final String displayTitle = Get.arguments?['title'] ?? title;

    return Scaffold(
      body: GetBuilder<LegalControllerImpl>(
        builder: (controller) => Stack(
          children: [
            PositionedLeft1(),
            PositionedRight3(),
            Padding(
              padding: EdgeInsets.only(top: 100.h),
              child: Handlingdataviwe(
                statusrequest: controller.statusrequest,
                ontryagain: () => controller.getLegalData(),
                shimmer: _buildShimmer(),
                widget: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  itemCount: controller.legalData.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h),
                  itemBuilder: (context, index) {
                    final item = controller.legalData[index];
                    return _buildLegalCard(item);
                  },
                ),
              ),
            ),
            PositionedAppBar(title: displayTitle, onPressed: Get.back),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalCard(LegalData item) {
    return Card(
      color: Colors.white.withValues(alpha: 0.8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title ?? "",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.primrycolor,
              ),
            ),
            SizedBox(height: 12.h),
            Html(
              data: item.content ?? "",
              style: {
                "body": Style(
                  fontSize: FontSize(15.sp),
                  color: Colors.black,
                  lineHeight: LineHeight(1.6),
                  fontWeight: FontWeight.bold,
                ),
              },
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
                  Container(
                    height: 24.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 100.h,
                    width: double.infinity,
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

import 'package:e_comerece/controller/local_service/local_service_details_controller.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/screen/local_serviess/widget/service_details_content.dart';
import 'package:e_comerece/viwe/screen/local_serviess/widget/service_details_image.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocalServiceDetailsView extends StatelessWidget {
  const LocalServiceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    LocalServiceDetailsController controller = Get.put(
      LocalServiceDetailsController(),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Custombuttonauth(
          inputtext: StringsKeys.chatForService.tr,
          onPressed: () {
            controller.goToChat();
          },
        ),
      ),
      body: Stack(
        children: [
          // 1. Header Image (Fixed Background)
          ServiceDetailsImage(controller: controller),

          // 2. Scrollable Content
          ServiceDetailsContent(controller: controller),
        ],
      ),
    );
  }
}

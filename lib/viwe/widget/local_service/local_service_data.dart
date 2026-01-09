import 'package:e_comerece/controller/local_service/local_service_controller.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocalServiceData extends GetView<LocalServiceController> {
  const LocalServiceData({super.key});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      isSizedBox: true,
      isSliver: true,
      statusrequest: controller.fetchstatusrequest,
      widget: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          mainAxisExtent: 330.h,
        ),

        itemCount: controller.services.length,
        itemBuilder: (context, index) {
          final service = controller.services[index];

          return InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutesname.localServiceDetails,
                arguments: {'service': service},
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Custgridviwe(
                image: Hero(
                  tag: service.id!,
                  child: CustomCachedImage(imageUrl: service.serviceImage!),
                ),
                description: service.serviceDesc!,
                title: service.serviceName!,
              ),
            ),
          );
        },
      ),
    );
  }
}

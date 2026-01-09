import 'package:e_comerece/controller/local_service/service_order_controller.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceOrderImage extends StatelessWidget {
  const ServiceOrderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceOrderController>(
      builder: (controller) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: 350.h,
        child: Hero(
          tag: controller.service.id ?? "service_image",
          child: CustomCachedImage(
            radius: 0,
            imageUrl: controller.service.serviceImage ?? "",
          ),
        ),
      ),
    );
  }
}

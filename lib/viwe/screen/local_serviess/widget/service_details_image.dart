import 'package:e_comerece/controller/local_service/local_service_details_controller.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDetailsImage extends StatelessWidget {
  final LocalServiceDetailsController controller;

  const ServiceDetailsImage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -5.h,
      left: 0,
      right: 0,
      height: 380.h,
      child: Hero(
        tag: controller.service.serviceId!,
        child: CustomCachedImage(
          radius: 15.r,
          imageUrl: controller.service.serviceImage ?? "",
        ),
      ),
    );
  }
}

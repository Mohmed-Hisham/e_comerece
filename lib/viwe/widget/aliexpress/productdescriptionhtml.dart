// دي اللي من غير تحريك الصور مع التصنيفات

import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/images_carousel_html.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ImagesCarousel extends StatelessWidget {
  final List<String> images;
  final double height;
  final String? tag;
  const ImagesCarousel({
    super.key,
    required this.images,
    this.height = 200,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return GetBuilder<ProductDetailsControllerImple>(
      tag: tag,
      id: 'index',
      builder: (controller) => ImagesCarouselHtml(
        carouselController: controller.carouselController,
        images: images,
        height: height,
        currentIndex: controller.currentIndex,
        onPageChanged: (index, reason) => controller.indexchange(index),
        onTap: (i) => controller.indexchange(i),
      ),
    );
  }
}

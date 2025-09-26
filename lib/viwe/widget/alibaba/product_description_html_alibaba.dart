import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/images_carousel_html.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ProductDescriptionHtmlAlibaba extends StatelessWidget {
  final List<String> images;
  final double height;
  const ProductDescriptionHtmlAlibaba({
    super.key,
    required this.images,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return GetBuilder<ProductDetailsAlibabaControllerImple>(
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

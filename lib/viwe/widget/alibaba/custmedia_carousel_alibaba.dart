import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/openFullimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustmediaCarouselAlibaba extends StatelessWidget {
  const CustmediaCarouselAlibaba({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      id: 'videoPlayerController',
      builder: (controller) {
        print('build media carousel');
        final chewieController = controller.chewieController;
        final imageList = controller.imageList;

        final hasVideo = chewieController != null;
        final itemCount = (hasVideo ? 1 : 0) + imageList.length;

        if (itemCount == 0) {
          return const SizedBox(
            height: 300,
            child: Center(child: Icon(Icons.image_not_supported)),
          );
        }

        return SizedBox(
          height: 300,
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: itemCount.toInt(),
            itemBuilder: (context, index) {
              Widget mediaWidget;
              if (hasVideo && index == 0) {
                mediaWidget = Chewie(controller: controller.chewieController!);
              } else {
                final imageIndex = hasVideo ? index - 1 : index;
                mediaWidget = GestureDetector(
                  onTap: () =>
                      openFullImage(context, "https:${imageList[imageIndex]}"),
                  child: CachedNetworkImage(
                    imageUrl: "https:${imageList[imageIndex]}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Loadingimage(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              }

              return AnimatedBuilder(
                animation: controller.pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (controller.pageController.position.haveDimensions) {
                    value = (controller.pageController.page! - index);
                    value = (1 - (value.abs() * 0.3)).clamp(0.8, 1.0);
                  }
                  return Center(
                    child: Transform.scale(
                      scale: value,
                      child: Container(
                        height: 250,
                        margin: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
                child: mediaWidget,
              );
            },
          ),
        );
      },
    );
  }
}

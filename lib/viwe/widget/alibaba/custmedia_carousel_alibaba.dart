import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/open_full_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustmediaCarouselAlibaba extends StatelessWidget {
  const CustmediaCarouselAlibaba({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      id: 'videoPlayerController',
      builder: (controller) {
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

        return Column(
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (value) {
                  final index = value % itemCount;
                  controller.indexchange(index);
                },
                itemBuilder: (context, index) {
                  final realIndex = index % itemCount;

                  Widget mediaWidget;
                  if (hasVideo && realIndex == 0) {
                    // عرض الفيديو
                    mediaWidget = Chewie(
                      controller: controller.chewieController!,
                    );
                  } else {
                    // عرض الصور
                    final imageIndex = hasVideo ? realIndex - 1 : realIndex;
                    mediaWidget = GestureDetector(
                      onTap: () =>
                          openFullImage(context, imageList[imageIndex]),
                      child: CachedNetworkImage(
                        imageUrl: secureUrl(imageList[imageIndex])!,
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
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  imageList.length + (hasVideo ? 1 : 0),
                  (index) => AnimatedContainer(
                    margin: const EdgeInsets.only(right: 5),
                    duration: const Duration(milliseconds: 300),
                    width: controller.currentIndex == index ? 10 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: controller.currentIndex == index
                          ? Appcolor.primrycolor
                          : Appcolor.threecolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

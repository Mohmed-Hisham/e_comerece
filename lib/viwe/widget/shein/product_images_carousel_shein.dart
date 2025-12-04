import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/shein/product_details_shein_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/open_full_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImagesCarouselShein extends StatelessWidget {
  final String? tag;
  const ProductImagesCarouselShein({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsSheinControllerImple>(
      tag: tag,
      id: 'imagesList',
      builder: (controller) {
        // final chewieController = controller.chewieController;
        final imageList = controller.imageListFromApi;

        // final hasVideo = chewieController != null;
        final itemCount = imageList.length;
        if (controller.statusrequestImagesList == Statusrequest.loading) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(90),
              height: 200,
              width: 200,
              child: CircularProgressIndicator(color: Appcolor.primrycolor),
            ),
          );
        }

        if (imageList.isEmpty) {
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

                  // عرض الصور
                  final imageIndex = realIndex;
                  mediaWidget = GestureDetector(
                    onTap: () => openFullImage(
                      context,
                      "https:${imageList[imageIndex]}",
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "https:${imageList[imageIndex]}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Loadingimage(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );

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
                  imageList.length,
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

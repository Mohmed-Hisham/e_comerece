import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/amazon_controllers/product_details_amazon_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/open_full_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImagesCarouselAmazon extends StatelessWidget {
  const ProductImagesCarouselAmazon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAmazonControllerImple>(
      id: 'videoPlayerController',
      builder: (controller) {
        final chewieController = controller.chewieController;
        final imageList = controller.getProductImages();

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
                        imageUrl: imageList[imageIndex],
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

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:e_comerece/controller/amazon_controllers/product_details_amazon_controller.dart';
// import 'package:e_comerece/core/constant/color.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProductImagesCarouselAmazon extends StatelessWidget {
//   const ProductImagesCarouselAmazon({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductDetailsAmazonControllerImple>(
//       id: 'index',
//       builder: (controller) {
//         final images = controller.getProductImages();
//         if (images.isEmpty) return const SizedBox.shrink();

//         return Column(
//           children: [
//             CarouselSlider(
//               options: CarouselOptions(
//                 onPageChanged: (index, reason) {
//                   controller.indexchange(index);
//                 },
//                 autoPlay: false,
//                 height: 300,
//                 enlargeCenterPage: true,
//                 viewportFraction: 0.9,
//               ),
//               items: images.map((imageUrl) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           imageUrl,
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               color: Colors.grey.shade200,
//                               child: const Icon(
//                                 Icons.image_not_supported,
//                                 size: 50,
//                                 color: Colors.grey,
//                               ),
//                             );
//                           },
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Container(
//                               color: Colors.grey.shade200,
//                               child: const Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ...List.generate(
//                   images.length,
//                   (index) => AnimatedContainer(
//                     margin: const EdgeInsets.only(right: 5),
//                     duration: const Duration(milliseconds: 300),
//                     width: controller.currentIndex == index ? 10 : 6,
//                     height: 6,
//                     decoration: BoxDecoration(
//                       color: controller.currentIndex == index
//                           ? Appcolor.primrycolor
//                           : Appcolor.threecolor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

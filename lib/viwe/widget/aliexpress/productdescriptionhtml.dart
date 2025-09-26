// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
// import 'package:e_comerece/core/shared/widget_shared/openFullimage.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// List<String> extractImageUrls(String html) {
//   final regex = RegExp(
//     r'''src=['"]?(\/\/[^'"\s>]+|https?:\/\/[^'"\s>]+)['"]?''',
//     caseSensitive: false,
//   );
//   final matches = regex.allMatches(html);
//   final urls = <String>[];
//   for (final m in matches) {
//     final raw = m.group(1)!;
//     final fixed = raw.startsWith('//') ? 'https:$raw' : raw;
//     urls.add(fixed);
//   }
//   return urls;
// }

// class ImagesCarousel extends StatelessWidget {
//   final List<String> images;
//   final double height;
//   final ScrollController thumbnailController =
//       ScrollController(); // ← إضافة ScrollController

//   ImagesCarousel({super.key, required this.images, this.height = 200});

//   @override
//   Widget build(BuildContext context) {
//     if (images.isEmpty) return const SizedBox.shrink();

//     return GetBuilder<ProductDetailsControllerImple>(
//       id: 'index',
//       builder: (controller) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (thumbnailController.hasClients) {
//             final itemWidth = 80;
//             final offset = itemWidth * controller.currentIndex.toDouble();

//             thumbnailController.animateTo(
//               offset,
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           }
//         });
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CarouselSlider.builder(
//               carouselController: controller.carouselController,
//               itemCount: images.length,
//               itemBuilder: (ctx, index, realIndex) {
//                 final url = images[index];
//                 return GestureDetector(
//                   onTap: () => openFullImage(context, url),
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     width: double.infinity,
//                     decoration: BoxDecoration(),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: CachedNetworkImage(
//                         imageUrl: url,
//                         fit: BoxFit.cover,
//                         width: double.infinity,

//                         placeholder: (context, url) => SizedBox(
//                           height: height,
//                           child: const Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         ),

//                         errorWidget: (context, url, error) => SizedBox(
//                           height: height,
//                           child: const Center(child: Icon(Icons.broken_image)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               options: CarouselOptions(
//                 autoPlay: true,
//                 autoPlayInterval: Duration(seconds: 3),
//                 enlargeCenterPage: true,
//                 height: height,
//                 viewportFraction: 1.0,
//                 enableInfiniteScroll: false,
//                 onPageChanged: (index, reason) => controller.indexchange(index),
//               ),
//             ),

//             const SizedBox(height: 8),

//             SizedBox(
//               height: 72,
//               child: ListView.separated(
//                 controller: thumbnailController,
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: images.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 8),
//                 itemBuilder: (ctx, i) {
//                   final url = images[i];
//                   return GestureDetector(
//                     onTap: () {
//                       controller.indexchange(i);
//                     },
//                     child: Container(
//                       width: 72,
//                       height: 72,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: i == controller.currentIndex
//                               ? Theme.of(context).primaryColor
//                               : Colors.grey.shade300,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(6),
//                         color: Colors.grey[100],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(4),
//                         child: CachedNetworkImage(
//                           placeholder: (context, url) =>
//                               const Center(child: CircularProgressIndicator()),

//                           imageUrl: url,
//                           fit: BoxFit.cover,
//                           errorWidget: (_, __, ___) =>
//                               const Icon(Icons.broken_image),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// دي اللي من غير تحريك الصور مع التصنيفات

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/images_carousel_html.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ImagesCarousel extends StatelessWidget {
  final List<String> images;
  final double height;
  const ImagesCarousel({super.key, required this.images, this.height = 200});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return GetBuilder<ProductDetailsControllerImple>(
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

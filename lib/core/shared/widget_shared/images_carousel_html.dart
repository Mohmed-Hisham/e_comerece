import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/open_full_image.dart';
import 'package:flutter/material.dart';

class ImagesCarouselHtml extends StatelessWidget {
  final List<String> images;
  final double height;
  final void Function(int, CarouselPageChangedReason) onPageChanged;
  final Function(int) onTap;
  final int currentIndex;
  final CarouselSliderController carouselController;
  const ImagesCarouselHtml({
    super.key,
    required this.images,
    required this.height,
    required this.onPageChanged,
    required this.onTap,
    required this.currentIndex,
    required this.carouselController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,

          itemCount: images.length,
          itemBuilder: (ctx, index, realIndex) {
            final url = images[index];
            return GestureDetector(
              onTap: () => openFullImage(context, url),
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        SizedBox(height: height, child: const Loadingimage()),
                    errorWidget: (context, url, error) => SizedBox(
                      height: height,
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            enlargeCenterPage: true,
            height: height,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: onPageChanged,
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 72,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, i) {
              final url = images[i];
              return GestureDetector(
                onTap: () {
                  onTap(i);
                  carouselController.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: i == currentIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Loadingimage(),

                      imageUrl: url,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

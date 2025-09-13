import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

List<String> extractImageUrls(String html) {
  final regex = RegExp(
    r'''src=['"]?(\/\/[^'"\s>]+|https?:\/\/[^'"\s>]+)['"]?''',
    caseSensitive: false,
  );
  final matches = regex.allMatches(html);
  final urls = <String>[];
  for (final m in matches) {
    final raw = m.group(1)!;
    final fixed = raw.startsWith('//') ? 'https:$raw' : raw;
    urls.add(fixed);
  }
  return urls;
}

/// Widget لعرض الصور في carousel مع thumbnails وفتح fullscreen عند النقر
class ImagesCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  const ImagesCarousel({super.key, required this.images, this.height = 300});

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  int _currentIndex = 0;

  void _openFull(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: EdgeInsets.all(10),
        child: SizedBox(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, event) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, error, stack) => const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (ctx, index, realIndex) {
            final url = widget.images[index];
            return GestureDetector(
              onTap: () => _openFull(context, url),
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

                    placeholder: (context, url) => SizedBox(
                      height: widget.height,
                      child: const Center(child: CircularProgressIndicator()),
                    ),

                    // progressIndicatorBuilder: (context, url, downloadProgress) {
                    //   final value = downloadProgress.progress;

                    //   return SizedBox(
                    //     height: widget.height,
                    //     child: Center(
                    //       child: value == null
                    //           ? const CircularProgressIndicator()
                    //           : CircularProgressIndicator(value: value),
                    //     ),
                    //   );
                    // },
                    errorWidget: (context, url, error) => SizedBox(
                      height: widget.height,
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 1),
            enlargeCenterPage: true,
            height: widget.height,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) =>
                setState(() => _currentIndex = index),
          ),
        ),

        const SizedBox(height: 8),

        // Thumbnails
        SizedBox(
          height: 72,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, i) {
              final url = widget.images[i];
              return GestureDetector(
                onTap: () {
                  setState(() => _currentIndex = i);
                },
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: i == _currentIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
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

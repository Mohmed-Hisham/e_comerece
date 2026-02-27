import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custcarouselslider extends StatelessWidget {
  final List<String> items;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  final int currentIndex;
  const Custcarouselslider({
    super.key,
    required this.items,
    required this.onPageChanged,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: onPageChanged,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            height: 200.h,
            enlargeCenterPage: true,
          ),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return CustomCachedImage(imageUrl: i, radius: 17.r);
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ...List.generate(
              items.length,
              (index) => AnimatedContainer(
                margin: const EdgeInsets.only(right: 5),
                duration: const Duration(milliseconds: 300),
                width: currentIndex == index ? 10 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: currentIndex == index
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
  }
}

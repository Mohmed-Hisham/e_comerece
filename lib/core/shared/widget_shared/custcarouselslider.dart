import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custcarouselslider extends StatelessWidget {
  final List<String> items;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final int? currentIndex;
  const Custcarouselslider({
    super.key,
    required this.items,
    this.onPageChanged,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: onPageChanged,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            height: 160,
            enlargeCenterPage: true,
          ),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(
                  i,
                  fit: BoxFit.contain,
                  width: double.infinity,
                );
              },
            );
          }).toList(),
        ),
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
                  color: Appcolor.primrycolor,
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

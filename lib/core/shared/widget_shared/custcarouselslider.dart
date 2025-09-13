import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Custcarouselslider extends StatelessWidget {
  final List<String> items;
  const Custcarouselslider({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        height: 200,
        enlargeCenterPage: true,
      ),
      items: items.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Image.asset(i, fit: BoxFit.contain, width: double.infinity);
          },
        );
      }).toList(),
    );
  }
}

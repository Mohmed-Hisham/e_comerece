import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SizeShimmer extends StatelessWidget {
  const SizeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            width: 70,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(6, (index) {
              return Container(
                width: 80,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

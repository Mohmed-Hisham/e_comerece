import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListHorizontal extends StatelessWidget {
  final bool isSlevr;
  const ShimmerListHorizontal({super.key, required this.isSlevr});

  @override
  Widget build(BuildContext context) {
    final widget = Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.all(8),
              width: 150.w,
              height: 170.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            SizedBox(height: 8.h),
            Container(width: 50, height: 12, color: Colors.white),
            SizedBox(height: 8.h),
            Container(width: 100.w, height: 12.h, color: Colors.white),
          ],
        ),
      ),
    );

    if (isSlevr) {
      return SliverList.separated(
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(width: 1),
        itemBuilder: (context, index) {
          return widget;
        },
      );
    } else {
      return SizedBox(
        height: 250.h,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(width: 1),
          itemBuilder: (context, index) {
            return widget;
          },
        ),
      );
    }
  }
}

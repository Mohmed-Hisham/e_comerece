import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 15,
      reverse: true,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      itemBuilder: (context, index) {
        bool isUser = index % 2 == 0;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: (150 + (index % 3) * 50).w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                    bottomLeft: isUser
                        ? Radius.circular(0)
                        : Radius.circular(10.r),
                    bottomRight: isUser
                        ? Radius.circular(10.r)
                        : Radius.circular(0),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

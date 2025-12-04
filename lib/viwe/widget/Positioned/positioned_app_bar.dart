import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PositionedAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double? top;
  const PositionedAppBar({
    super.key,
    this.onPressed,
    required this.title,
    this.top = 35,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Row(
        spacing: 10.w,
        children: [
          SizedBox(height: 20.h),
          onPressed == null
              ? const SizedBox()
              : IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                    size: 38.sp,
                  ),
                ),

          Text(
            title,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppBar content without Positioned wrapper
/// Use this inside Column, Row, etc.
class AppBarContent extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const AppBarContent({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

/// AppBar with Positioned wrapper - USE ONLY INSIDE Stack
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
      left: 0,
      right: 0,
      child: AppBarContent(onPressed: onPressed, title: title),
    );
  }
}

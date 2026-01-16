import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loadingWidget({Color? color, double? height, double? width}) => Center(
  child: SizedBox(
    height: height ?? 28.h,
    width: width ?? 26.w,
    child: CircularProgressIndicator(
      color: color ?? Appcolor.primrycolor,
      strokeWidth: 3,
      strokeCap: StrokeCap.round,
    ),
  ),
);

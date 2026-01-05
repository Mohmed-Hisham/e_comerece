import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showCustomGetSnack({
  bool close = true,
  required bool isGreen,
  required String text,
  Duration duration = const Duration(seconds: 2),
}) {
  if (Get.isSnackbarOpen && close) Get.back();
  Get.rawSnackbar(
    titleText: const SizedBox.shrink(),
    backgroundColor: Colors.transparent,
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.BOTTOM,
    maxWidth: Get.width * 0.95,
    margin: EdgeInsets.only(left: 12, right: 12, bottom: 18),
    padding: EdgeInsets.zero,
    borderRadius: 0,
    duration: duration,
    messageText: Container(
      decoration: BoxDecoration(
        color: isGreen
            ? const Color.fromRGBO(213, 255, 236, 1)
            : const Color.fromRGBO(255, 207, 222, 1),
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.h,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Center(),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isGreen
                    ? const Color.fromRGBO(59, 183, 126, 1)
                    : const Color.fromRGBO(247, 75, 129, 1),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.close, size: 19.sp, color: Colors.black26),
          ),
        ],
      ),
    ),
  );
}

void showCustomContextSnack({
  required BuildContext context,
  required bool isGreen,
  required String text,
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
      dismissDirection: DismissDirection.horizontal,
      duration: duration,
      content: Container(
        decoration: BoxDecoration(
          color: isGreen
              ? const Color.fromRGBO(213, 255, 236, 1)
              : const Color.fromRGBO(255, 207, 222, 1),
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 30.w,
              height: 30.h,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Center(),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isGreen
                      ? const Color.fromRGBO(59, 183, 126, 1)
                      : const Color.fromRGBO(247, 75, 129, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: Icon(Icons.close, size: 20.sp, color: Colors.black26),
            ),
          ],
        ),
      ),
    ),
  );
}

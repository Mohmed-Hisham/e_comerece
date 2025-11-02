import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomGetSnack({
  required bool isGreen,
  required String text,
  Duration duration = const Duration(seconds: 2),
}) {
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
            width: 30,
            height: 30,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Center(),
          ),
          SizedBox(width: 12),
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
            child: const Icon(Icons.close, size: 18, color: Colors.black26),
          ),
        ],
      ),
    ),
  );
}

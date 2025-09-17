import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openFullImage(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      insetPadding: EdgeInsets.all(10),
      child: SizedBox(
        child: InkWell(
          onTap: () => Get.back(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: url,
              placeholder: (context, event) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, error, stack) => const Center(
                child: Icon(Icons.broken_image, color: Colors.white, size: 40),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

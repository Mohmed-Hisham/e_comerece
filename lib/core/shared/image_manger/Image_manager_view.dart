import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageManagerView extends StatelessWidget {
  final Widget defaultBuilder;
  final Widget Function(XFile image)? imageBuilder;
  final void Function(XFile image) onImagePicked;

  const ImageManagerView({
    super.key,
    required this.defaultBuilder,
    this.imageBuilder,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ImageManagerController>();

    return GestureDetector(
      onTap: controller.pickImage,
      child: GetBuilder<ImageManagerController>(
        builder: (controller) {
          if (controller.image != null) {
            onImagePicked(controller.image!);
            if (imageBuilder == null) {
              return defaultBuilder;
            } else {
              return imageBuilder!(controller.image!);
            }
          }
          return defaultBuilder;
        },
      ),
    );
  }
}

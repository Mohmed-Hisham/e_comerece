import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageManagerController extends GetxController {
  XFile? image;

  Future<XFile> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        image = pickedImage;
        log(image!.path);
        return image!;
      }
    } catch (e) {
      log('pickImage error: $e');
    }

    return XFile('');
  }
}

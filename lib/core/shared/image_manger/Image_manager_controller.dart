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
        print(image!.path);
        return image!;
      }
    } catch (e) {
      print('pickImage error: $e');
    }

    return XFile('');
  }
}

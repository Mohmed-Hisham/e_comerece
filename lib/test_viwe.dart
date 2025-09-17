import 'dart:io';
import 'package:e_comerece/core/shared/image_manger/Image_manager_controller.dart';
import 'package:e_comerece/core/shared/image_manger/Image_manager_view.dart';
import 'package:e_comerece/data/datasource/remote/upload_to_cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TestViwe extends StatelessWidget {
  const TestViwe({super.key});

  // استبدل ال uploadPreset بالقيمة اللي في Cloudinary Dashboard
  static const String uploadPreset = 'ecommerce_unsigned';
  static const String cloudName = 'dgonvbimk';

  @override
  Widget build(BuildContext context) {
    Get.put(ImageManagerController());

    return Scaffold(
      appBar: AppBar(title: const Text('اختبار الرفع')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ImageManagerView(
              defaultBuilder: ElevatedButton(
                onPressed: Get.find<ImageManagerController>().pickImage,
                child: Icon(Icons.add_a_photo),
              ),
              // imageBuilder: (image) => Container(
              //   height: 200,
              //   width: 200,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey),
              //   ),
              //   child: Image.file(File(image.path), fit: BoxFit.cover),
              // ),
              onImagePicked: (XFile image) {
                uploadToCloudinary(
                      filePath: image.path,
                      cloudName: cloudName,
                      uploadPreset: uploadPreset,
                    )
                    .then((url) {
                      if (url != null) {
                        print('Uploaded to: $url');
                      } else {}
                    })
                    .catchError((err) {
                      print('Error: $err');
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

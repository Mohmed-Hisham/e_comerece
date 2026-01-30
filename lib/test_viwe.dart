// import 'package:e_comerece/core/shared/image_manger/image_manag_controller.dart';
// import 'package:e_comerece/core/shared/image_manger/image_manag_view.dart';
// // import 'package:e_comerece/data/datasource/remote/upload_to_cloudinary.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';

// class TestViwe extends StatelessWidget {
//   const TestViwe({super.key});

//   static const String uploadPreset = 'ecommerce_unsigned';
//   static const String cloudName = 'dgonvbimk';

//   @override
//   Widget build(BuildContext context) {
//     Get.put(ImageManagerController());

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Center(
//           child: ImageManagerView(
//             defaultBuilder: ElevatedButton(
//               onPressed: Get.find<ImageManagerController>().pickImage,
//               child: Icon(Icons.add_a_photo),
//             ),

//             // onImagePicked: (XFile image) {
//             //   uploadToCloudinary(
//             //         filePath: image.path,
//             //         cloudName: cloudName,
//             //         uploadPreset: uploadPreset,
//             //       )
//             //       .then((url) {
//             //         if (url != null) {
//             //         } else {}
//             //       })
//             //       .catchError((err) {});
//             // },
//           ),
//         ),
//       ],
//     );
//   }
// }

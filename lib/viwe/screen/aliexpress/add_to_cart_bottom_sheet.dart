// import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
// import 'package:e_comerece/controller/cart/cart_from_detils.dart';
// import 'package:e_comerece/core/class/handlingdataviwe.dart';
// import 'package:e_comerece/core/loacallization/strings_keys.dart';
// import 'package:e_comerece/viwe/widget/aliexpress/buildheader.dart';
// import 'package:e_comerece/viwe/widget/aliexpress/buildaddtocartbutton.dart';
// import 'package:e_comerece/viwe/widget/buildselectedattributes.dart';
// import 'package:e_comerece/viwe/widget/maps/shaimmer_botton_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class AddToCartBottomSheet extends StatelessWidget {
//   final ProductDetailsControllerImple controller;
//   final AddorrmoveControllerimple addcontroller;
//   final String? tag;

//   const AddToCartBottomSheet({
//     super.key,
//     required this.controller,
//     required this.addcontroller,
//     this.tag,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductDetailsControllerImple>(
//       id: 'quantity',
//       tag: tag,
//       builder: (controller) {
//         return HandlingdataviweNoEmty(
//           shimmer: LocationInfoShimmer(
//             borderRadius: BorderRadius.circular(20.r),
//             height: 400.h,
//           ),
//           statusrequest: controller.statusrequestquantity,
//           widget: Container(
//             padding: const EdgeInsets.all(16),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Buildheader(controller: controller),
//                   const SizedBox(height: 16),
//                   Buildselectedattributes(controller: controller),
//                   const SizedBox(height: 16),
//                   _buildQuantitySelector(context, addcontroller),
//                   const SizedBox(height: 24),
//                   Buildaddtocartbutton(
//                     cartController: addcontroller,
//                     controller: controller,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildQuantitySelector(
//     BuildContext context,
//     AddorrmoveControllerimple addcontroller,
//   ) {
//     return GetBuilder<ProductDetailsControllerImple>(
//       tag: tag,
//       id: 'quantity',
//       builder: (controller) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               StringsKeys.quantity.tr,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.remove),
//                   onPressed: () {
//                     // final attributesJson = jsonEncode(
//                     //   buildDisplayAttributes(controller),
//                     // );
//                     controller.decrementQuantity();

//                     // addcontroller.removprise(
//                     //   cartModel: CartModel(
//                     //     productId: controller.productId!.toString(),
//                     //     cartAttributes: attributesJson,
//                     //     cartQuantity: controller.quantity,
//                     //   ),
//                     // );
//                   },
//                 ),
//                 GetBuilder<ProductDetailsControllerImple>(
//                   tag: tag,
//                   builder: (ctrl) {
//                     return Text(
//                       "${ctrl.quantity}",
//                       style: Theme.of(context).textTheme.titleMedium,
//                     );
//                   },
//                 ),

//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     // final attributesJson = jsonEncode(
//                     //   buildDisplayAttributes(controller),
//                     // );
//                     controller.incrementQuantity();
//                     // addcontroller.addprise(
//                     //   cartModel: CartModel(
//                     //     productId: controller.productId!.toString(),
//                     //     cartAttributes: attributesJson,
//                     //     cartQuantity: controller.quantity,
//                     //   ),
//                     //   availablequantity:
//                     //       controller.currentSku?.skuVal?.availQuantity ?? 0,
//                     // );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

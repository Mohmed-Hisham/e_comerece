// import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
// import 'package:e_comerece/data/model/alibaba_model/product_ditels_alibaba_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// class CustBuildPricedisplayAlibaba extends StatelessWidget {
//   const CustBuildPricedisplayAlibaba({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductDetailsAlibabaControllerImple>(
//       id: 'selectedAttributes',
//       builder: (controller) {
//         // final originalPrice = controller.currentSku?.skuVal?.skuAmount;
//         // print("originalPrice============================:$originalPrice");
//         return Container(
//           height: 100,
//           width: 500,
//           child: ListView.builder(
//             itemCount: controller.priceList.length,

//             itemBuilder: (context, index) {
//               final item = controller.priceList[index];
//               print("item============================:$item");
//               return Column(
//                 children: [
//                   Text(item.minQuantity!.toString()),
//                   // Text(item.priceFormatted!.toString()),
//                   // Text(item.maxQuantity!.toString()),
//                 ],
//               );
//             },
//           ),
//         );
//         //  Row(
//         //   children: [
//         //     // if (price != null)
//         //     //   Text(
//         //     //     price.formatedAmount!,
//         //     //     style: Theme.of(
//         //     //       context,
//         //     //     ).textTheme.headlineMedium?.copyWith(color: Colors.red),
//         //     //   ),
//         //     // const SizedBox(width: 8),
//         //     // if (originalPrice != null && price?.value != originalPrice.value)
//         //     //   Text(
//         //     //     originalPrice.formatedAmount!,
//         //     //     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//         //     //       color: Colors.grey,
//         //     //       decoration: TextDecoration.lineThrough,
//         //     //     ),
//         //     //   ),
//         //   ],
//         // );
//       },
//     );
//   }
// }

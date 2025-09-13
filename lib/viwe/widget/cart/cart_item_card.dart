import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends StatelessWidget {
  final CartModel cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final attributes = jsonDecode(cartItem.cartAttributes!);
    final controller = Get.find<CartController>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          controller.gotoproductdetails(
            int.parse(cartItem.productId!.toString()),
            enOrAr(),
          );
        },
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: "https:${cartItem.cartProductImage}",
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  height: 30,
                  width: 30,
                  top: -5,
                  left: -5,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Appcolor.somgray,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      alignment: Alignment.center,
                      iconSize: 15,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Appcolor.primrycolor,
                      ),
                      onPressed: () {
                        controller.removeItem(cartItem.cartId!);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.cartProductTitle!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        cartItem.cartPrice!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          _showProductDetails(context, attributes);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Appcolor.gray),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "more",
                            style: TextStyle(
                              height: 1.1,
                              color: Appcolor.primrycolor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GetBuilder<CartController>(
              id: "1",
              builder: (addRemoveController) => Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Appcolor.somgray,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        addRemoveController.addprise(cartModel: cartItem);
                      },
                      icon: const Icon(Icons.add, size: 20),
                    ),
                  ),
                  Text('  ${cartItem.cartQuantity}  '),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Appcolor.somgray,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        addRemoveController.removprise(cartModel: cartItem);
                      },
                      icon: const Icon(Icons.remove, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(
    BuildContext context,
    Map<String, dynamic> attributes,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ..._buildAttributeWidgets(attributes),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAttributeWidgets(Map<String, dynamic> attributes) {
    List<Widget> widgets = [];

    attributes.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        final String? imageName = value['name'] as String?;
        final String? imageUrl = value['image'] as String?;

        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$key: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (imageUrl != null && imageUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: "https:$imageUrl",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                if (imageName != null)
                  Expanded(
                    child: Text(
                      imageName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
        );
      } else {
        print(
          "Unexpected attribute format for key '$key': value is ${value.runtimeType}",
        );
      }
    });

    return widgets;
  }
}

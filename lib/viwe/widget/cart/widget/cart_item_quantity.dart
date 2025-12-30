import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartItemQuantity extends StatelessWidget {
  final CartModel cartItem;
  final CartControllerImpl controller;

  const CartItemQuantity({
    super.key,
    required this.cartItem,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartControllerImpl>(
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
              icon: const FaIcon(FontAwesomeIcons.plus, size: 20),
            ),
          ),
          Text(
            '  ${cartItem.cartQuantity}  ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
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
              icon: const FaIcon(FontAwesomeIcons.minus, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

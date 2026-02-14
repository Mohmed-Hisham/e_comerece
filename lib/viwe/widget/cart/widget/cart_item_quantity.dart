import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartItemQuantity extends StatelessWidget {
  final CartData cartItem;
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
      builder: (addRemoveController) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.add_rounded,
            onTap: () => addRemoveController.addprise(cartData: cartItem),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(
              '${cartItem.cartQuantity}',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.black,
              ),
            ),
          ),
          _buildButton(
            icon: Icons.remove_rounded,
            onTap: () => addRemoveController.removprise(cartData: cartItem),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
          color: Appcolor.primrycolor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Appcolor.primrycolor.withValues(alpha: 0.3),
          ),
        ),
        child: Icon(icon, size: 18.sp, color: Appcolor.primrycolor),
      ),
    );
  }
}

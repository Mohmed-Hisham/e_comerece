import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomAddToCartBar extends StatelessWidget {
  final LocalProductModel product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onAddToCart;

  const BottomAddToCartBar({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Appcolor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              _buildQuantitySelector(),
              SizedBox(width: 16.w),
              _buildAddToCartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: Appcolor.white2,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onDecrement,
            icon: Icon(Icons.remove, color: Appcolor.primrycolor, size: 20.sp),
          ),
          Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
          IconButton(
            onPressed: onIncrement,
            icon: Icon(Icons.add, color: Appcolor.primrycolor, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.primrycolor,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.cartPlus,
              color: Appcolor.white,
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              StringsKeys.addToCart.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/circular_widget.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

enum CartButtonState { addToCart, updateInCart, added, loadingAddButton }

enum FavoritButtonState { addToFavorite, added }

class BottomAddToCartBar extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onAddToCart;
  final Widget onToggleFavorite;
  final bool isLoading;
  final CartButtonState buttonState;

  const BottomAddToCartBar({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAddToCart,
    required this.onToggleFavorite,

    this.isLoading = false,
    this.buttonState = CartButtonState.addToCart,
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
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: isLoading
              ? _buildLoadingShimmer()
              : Row(
                  children: [
                    onToggleFavorite,
                    SizedBox(width: 10.w),

                    _buildQuantitySelector(),
                    SizedBox(width: 16.w),
                    _buildAddToCartButton(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          // Shimmer for quantity selector
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(width: 16.w),

          Expanded(
            flex: 2,

            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
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
        onPressed: buttonState == CartButtonState.added ? () {} : onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonState == CartButtonState.added
              ? Colors.green
              : Appcolor.primrycolor,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: buttonState == CartButtonState.loadingAddButton
            ? loadingWidget(color: Appcolor.white, height: 17.h, width: 17.w)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(_getButtonIcon(), color: Appcolor.white, size: 18.sp),
                  SizedBox(width: 8.w),
                  Text(
                    _getButtonText(),
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

  String _getButtonText() {
    switch (buttonState) {
      case CartButtonState.addToCart:
        return StringsKeys.addToCart.tr;
      case CartButtonState.updateInCart:
        return StringsKeys.updateCart.tr;
      case CartButtonState.added:
        return StringsKeys.addedToCart.tr;
      case CartButtonState.loadingAddButton:
        return "".tr;
    }
  }

  IconData _getButtonIcon() {
    switch (buttonState) {
      case CartButtonState.addToCart:
        return FontAwesomeIcons.cartPlus;
      case CartButtonState.updateInCart:
        return FontAwesomeIcons.rotate;
      case CartButtonState.added:
        return FontAwesomeIcons.check;
      case CartButtonState.loadingAddButton:
        return FontAwesomeIcons.spinner;
    }
  }
}

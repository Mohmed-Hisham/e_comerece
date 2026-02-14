import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/bottom_add_to_cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddButtonToCart extends StatelessWidget {
  final String? tag;
  const AddButtonToCart({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsControllerImple>(
      id: 'quantity',
      tag: tag,
      builder: (controller) {
        return BottomAddToCartBar(
          onToggleFavorite: GetBuilder<FavoritesController>(
            builder: (favController) {
              final productId = controller.productId?.toString() ?? '';
              bool isFav = favController.isFavorite[productId] ?? false;

              return IconButton(
                onPressed: () {
                  favController.toggleFavorite(
                    controller.productId.toString(),
                    controller.itemDetailsModel!.result!.item!.title!,
                    controller.itemDetailsModel!.result!.item!.images[0],
                    controller.getRawUsdPrice().toString(),
                    "Aliexpress",
                  );
                },
                icon: FaIcon(
                  isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                  color: Appcolor.reed,
                  size: 22.sp,
                ),
              );
            },
          ),
          quantity: controller.quantity,
          onIncrement: controller.incrementQuantity,
          onDecrement: controller.decrementQuantity,
          onAddToCart: () => controller.addTOCart(),
          isLoading: controller.isInfoLoading,
          buttonState: controller.cartButtonState,
        );
      },
    );
  }
}

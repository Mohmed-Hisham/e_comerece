import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OurProductGridItem extends StatelessWidget {
  final LocalProductModel product;
  final CurrencyService currencyService;
  final VoidCallback onTap;
  final Widget favoriteButton;

  const OurProductGridItem({
    super.key,
    required this.product,
    required this.currencyService,
    required this.onTap,
    required this.favoriteButton,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Custgridviwe(
        image: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CustomCachedImage(imageUrl: product.mainImage ?? ""),
        ),
        disc: product.discountPercent != null
            ? "${product.discountPercent}%"
            : null,
        title: product.title ?? "",
        price: currencyService.convertAndFormat(
          amount: product.discountPrice ?? product.price ?? 0,
          from: 'USD',
        ),
        icon: favoriteButton,
        discprice: product.hasDiscount
            ? currencyService.convertAndFormat(
                amount: product.price ?? 0,
                from: 'USD',
              )
            : null,
        countsall: product.stockQuantity != null
            ? "${product.stockQuantity}${StringsKeys.inStock.tr}"
            : null,
      ),
    );
  }
}

class OurProductFavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const OurProductFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(
        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        color: Appcolor.reed,
        size: 20.sp,
      ),
    );
  }
}

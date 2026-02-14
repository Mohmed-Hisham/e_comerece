import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RelatedProductCard extends StatelessWidget {
  final LocalProductModel product;
  final CurrencyService currencyService;

  const RelatedProductCard({
    super.key,
    required this.product,
    required this.currencyService,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutesname.ourProductDetails,
          arguments: {'product': product},
          preventDuplicates: false,
        );
      },
      child: Container(
        width: 160.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: Appcolor.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageSection(), _buildProductInfo()],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
          child: SizedBox(
            height: 140.h,
            width: double.infinity,
            child: Hero(
              tag: product.id ?? "",
              child: CustomCachedImage(
                imageUrl: product.mainImage ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        if (product.hasDiscount) _buildDiscountBadge(),
        _buildFavoriteButton(),
      ],
    );
  }

  Widget _buildDiscountBadge() {
    return Positioned(
      top: 8.h,
      left: 8.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Appcolor.reed,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          "-${product.discountPercent}%",
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            color: Appcolor.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 8.h,
      right: 8.w,
      child: GetBuilder<FavoritesController>(
        builder: (favController) {
          final productId = product.id?.toString() ?? "";
          bool isFav = favController.isFavorite[productId] ?? false;

          return InkWell(
            onTap: () {
              favController.toggleFavorite(
                productId,
                product.title ?? "",
                product.mainImage ?? "",
                (product.discountPrice ?? product.price ?? 0).toString(),
                "LocalProduct",
                categoryid: product.categoryId?.toString(),
              );
            },
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Appcolor.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: FaIcon(
                isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: Appcolor.reed,
                size: 14.sp,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Appcolor.black,
            ),
          ),
          SizedBox(height: 6.h),
          _buildPriceRow(),
        ],
      ),
    );
  }

  Widget _buildPriceRow() {
    return Column(
      children: [
        Text(
          currencyService.convertAndFormat(
            amount: product.discountPrice ?? product.price ?? 0,
            from: 'USD',
          ),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Appcolor.primrycolor,
          ),
        ),
        if (product.hasDiscount) ...[
          SizedBox(width: 6.w),
          Text(
            currencyService.convertAndFormat(
              amount: product.price ?? 0,
              from: 'USD',
            ),
            style: TextStyle(
              fontSize: 10.sp,
              color: Appcolor.gray,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}

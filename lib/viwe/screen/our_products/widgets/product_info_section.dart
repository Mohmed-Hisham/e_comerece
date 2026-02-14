import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductInfoSection extends StatelessWidget {
  final LocalProductModel product;
  final CurrencyService currencyService;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.currencyService,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndFavorite(),
          SizedBox(height: 12.h),
          _buildPriceSection(),
          SizedBox(height: 16.h),
          _buildStatsRow(),
        ],
      ),
    );
  }

  Widget _buildTitleAndFavorite() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.title ?? "",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
        ),
        // GetBuilder<FavoritesController>(
        //   builder: (favController) {
        //     final productId = product.id?.toString() ?? "";
        //     bool isFav = favController.isFavorite[productId] ?? false;

        //     return IconButton(
        //       onPressed: () {
        //         favController.toggleFavorite(
        //           productId,
        //           product.title ?? "",
        //           product.mainImage ?? "",
        //           (product.discountPrice ?? product.price ?? 0).toString(),
        //           "LocalProduct",
        //           categoryid: product.categoryId?.toString(),
        //         );
        //       },
        //       icon: FaIcon(
        //         isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        //         color: Appcolor.reed,
        //         size: 22.sp,
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          currencyService.convertAndFormat(
            amount: product.discountPrice ?? product.price ?? 0,
            from: 'USD',
          ),
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Appcolor.primrycolor,
          ),
        ),
        if (product.hasDiscount) ...[
          SizedBox(width: 12.w),
          Text(
            currencyService.convertAndFormat(
              amount: product.price!,
              from: 'USD',
            ),
            style: TextStyle(
              fontSize: 16.sp,
              color: Appcolor.gray,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Appcolor.reed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              "-${product.discountPercent}%",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.reed,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        if (product.categoryName != null)
          _buildStatItem(Icons.category_outlined, product.categoryName!),
        if (product.stockQuantity != null) ...[
          SizedBox(width: 16.w),
          _buildStatItem(
            Icons.inventory_2_outlined,
            "${product.stockQuantity} ${StringsKeys.inStock.tr}",
            iconColor: product.stockQuantity! > 0
                ? Colors.green
                : Appcolor.reed,
          ),
        ],
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String text, {Color? iconColor}) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: iconColor ?? Appcolor.gray),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(fontSize: 13.sp, color: Appcolor.gray),
        ),
      ],
    );
  }
}

import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_list_horizontal.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OurProductsHomeSection extends StatelessWidget {
  const OurProductsHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'ourProducts',
      builder: (controller) {
        return HandlingdatRequestNoFild(
          shimmer: ShimmerListHorizontal(isSlevr: false, count: 2),
          isSliver: true,
          statusrequest: controller.ourProductsStatusRequest,
          widget: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    CustLabelContainer(
                      text: StringsKeys.ourProductsYouMightLike.tr,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              _buildProductsGrid(controller),
              if (controller.hasMoreOurProducts &&
                  controller.isLoadingMoreOurProducts)
                const SliverToBoxAdapter(
                  child: ShimmerBar(height: 8, animationDuration: 1),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid(HomescreenControllerImple controller) {
    final currencyService = Get.find<CurrencyService>();

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.58,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = controller.ourProducts[index];
          return _buildProductItem(product, currencyService);
        }, childCount: controller.ourProducts.length),
      ),
    );
  }

  Widget _buildProductItem(product, CurrencyService currencyService) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutesname.ourProductDetails,
          arguments: {'product': product},
        );
      },
      borderRadius: BorderRadius.circular(15.r),
      child: Custgridviwe(
        image: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Hero(
            tag: product.id ?? "",
            child: CustomCachedImage(imageUrl: product.mainImage ?? ""),
          ),
        ),
        disc: product.discountPercent != null
            ? "${product.discountPercent}%"
            : null,
        title: product.title ?? "",
        price: currencyService.convertAndFormat(
          amount: product.discountPrice ?? product.price ?? 0,
          from: 'USD',
        ),
        icon: GetBuilder<FavoritesController>(
          builder: (favController) {
            final productId = product.id?.toString() ?? "";
            bool isFav = favController.isFavorite[productId] ?? false;

            return IconButton(
              onPressed: () {
                favController.toggleFavorite(
                  productId,
                  product.title ?? "",
                  product.mainImage ?? "",
                  (product.discountPrice ?? product.price ?? 0).toString(),
                  "LocalProduct",
                  categoryid: product.categoryId?.toString(),
                  goodsSn: "",
                );
              },
              icon: FaIcon(
                isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: Appcolor.reed,
                size: 20.sp,
              ),
            );
          },
        ),
        discprice: product.hasDiscount
            ? currencyService.convertAndFormat(
                amount: product.price!,
                from: 'USD',
              )
            : null,
        countsall: product.stockQuantity != null
            ? "${product.stockQuantity} ${StringsKeys.inStock.tr}"
            : null,
      ),
    );
  }
}

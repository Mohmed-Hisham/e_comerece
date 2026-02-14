import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/our_products/our_products_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/our_product_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OurProductsGrid extends GetView<OurProductsController> {
  const OurProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OurProductsController>(
      id: 'products',
      builder: (controller) {
        return Handlingdataviwe(
          statusrequest: controller.statusRequest,
          widget: controller.products.isEmpty
              ? _buildEmptyState()
              : _buildProductsGrid(controller),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80.sp,
            color: Appcolor.gray.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            StringsKeys.noProductsFound.tr,
            style: TextStyle(color: Appcolor.gray, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(OurProductsController controller) {
    final currencyService = Get.find<CurrencyService>();

    return PaginationListener(
      onLoadMore: () => controller.loadMore(),
      fetchAtEnd: true,
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.58,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = controller.products[index];

                return OurProductGridItem(
                  product: product,
                  currencyService: currencyService,
                  onTap: () {
                    Get.toNamed(
                      AppRoutesname.ourProductDetails,
                      arguments: {'product': product},
                    );
                  },
                  favoriteButton: GetBuilder<FavoritesController>(
                    builder: (favController) {
                      final productId = product.id?.toString() ?? "";
                      bool isFav = favController.isFavorite[productId] ?? false;

                      return OurProductFavoriteButton(
                        isFavorite: isFav,
                        onPressed: () {
                          favController.toggleFavorite(
                            productId,
                            product.title ?? "",
                            product.mainImage ?? "",
                            (product.discountPrice ?? product.price ?? 0)
                                .toString(),
                            "LocalProduct",
                            categoryid: product.categoryId?.toString(),
                            goodsSn: "",
                          );
                        },
                      );
                    },
                  ),
                );
              }, childCount: controller.products.length),
            ),
          ),
          if (controller.hasMore && controller.isLoadingMore)
            const SliverToBoxAdapter(
              child: ShimmerBar(height: 8, animationDuration: 1),
            ),
        ],
      ),
    );
  }
}

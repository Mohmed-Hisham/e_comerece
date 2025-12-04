import 'package:e_comerece/controller/alibaba/product_alibaba_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/helper/pagination_listener.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/alibaba/extension_geter_product_home.dart';
import 'package:e_comerece/viwe/screen/alibaba/seetings_alibaba.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchNameAlibaba extends StatelessWidget {
  final ProductAlibabaHomeControllerImp controller;
  const SearchNameAlibaba({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Appcolor.primrycolor,
      backgroundColor: Colors.transparent,
      onRefresh: () =>
          controller.searshText(q: controller.searchController.text),
      child: Column(
        children: [
          SeetingsAlibaba(),

          Expanded(
            child: PaginationListener(
              onLoadMore: controller.loadMoreSearch,
              isLoading: controller.isLoadingSearch,
              fetchAtEnd: true,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 330.h,
                ),
                itemCount: controller.searchProducts.length,
                itemBuilder: (context, index) {
                  final item = controller.searchProducts[index];

                  return InkWell(
                    onTap: () {
                      int id = item.itemid;
                      controller.gotoditels(
                        id: id,
                        title: item.titel,
                        lang: detectLangFromQuery(
                          controller.searchController.text,
                        ),
                      );
                    },
                    child: Custgridviwe(
                      image: CustomCachedImage(imageUrl: item.mainImageUrl),
                      disc: item.skuPriceFormatted,
                      title: item.titel,
                      price: item.skuPriceFormatted,
                      icon: GetBuilder<FavoritesController>(
                        builder: (isFavoriteController) {
                          bool isFav =
                              isFavoriteController.isFavorite[item.itemid
                                  .toString()] ??
                              false;

                          return IconButton(
                            onPressed: () {
                              isFavoriteController.toggleFavorite(
                                item.itemid.toString(),
                                item.titel,
                                item.mainImageUrl,
                                item.skuPriceFormatted,
                                "Alibaba",
                              );
                            },
                            icon: FaIcon(
                              isFav
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              color: isFav ? Appcolor.reed : Appcolor.reed,
                            ),
                          );
                        },
                      ),
                      discprice: item.skuPriceFormatted,
                      countsall: item.minOrderFormatted,
                      isAlibaba: true,
                      images: SizedBox(
                        height: 30,
                        child: ListView.builder(
                          cacheExtent: 500,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: item.imageUrls.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Text(
                                  StringsKeys.allColors.trParams({
                                    'number': item.imageUrls.length.toString(),
                                  }),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Appcolor.primrycolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              );
                            }

                            final img = item.imageUrls[index - 1];

                            return Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ClipOval(
                                child: CustomCachedImage(
                                  imageUrl: img,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (controller.isLoadingSearch &&
              controller.hasMoresearch &&
              controller.pageIndexSearch > 0)
            ShimmerBar(height: 8, animationDuration: 1),
        ],
      ),
    );
  }
}

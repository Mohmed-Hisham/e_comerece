import 'package:e_comerece/controller/favorite/favorite_view_platform_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoritesAliexpries extends StatelessWidget {
  const FavoritesAliexpries({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteViewPlatformControllerImpl());
    return Scaffold(
      body: GetBuilder<FavoriteViewPlatformControllerImpl>(
        builder: (controller) => RefreshIndicator(
          color: Appcolor.primrycolor,
          backgroundColor: Colors.transparent,
          onRefresh: () async =>
              controller.getFavoritesPlatform(platform: controller.platform),
          child: Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(
                title: StringsKeys.favoritesPlatform.trParams({
                  'platform': controller.platform,
                }),
                onPressed: Get.back,
              ),
              Handlingdataviwe(
                statusrequest: controller.statusrequest,
                widget: Column(
                  children: [
                    SizedBox(height: 110.h),
                    Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        itemCount: controller.favorites.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.w,
                          mainAxisExtent: 370.h,
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.favorites[index];
                          return InkWell(
                            onTap: () => controller.goToProductDetails(
                              item.productId!,
                              enOrAr(),
                              item.productTitle!,
                              item.productId!,
                              item.goodsSn!,
                              item.categoryId!,
                            ),
                            child: Custgridviwe(
                              image: CustomCachedImage(
                                imageUrl: item.productImage ?? '',
                              ),
                              disc: item.productPrice?.toString(),
                              title: item.productTitle!,
                              price: item.productPrice?.toString(),
                              icon: IconButton(
                                onPressed: () =>
                                    controller.removeFavorite(item.productId!),

                                icon: Icon(
                                  Icons.favorite_rounded,
                                  color: Appcolor.primrycolor,
                                ),
                              ),
                              discprice: item.productPrice?.toString(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

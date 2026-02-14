import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorite_view_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteViewController());
    final currencyService = Get.find<CurrencyService>();
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          PositionedAppBar(
            title: StringsKeys.favoritesAll.tr,
            onPressed: Get.back,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120.h),
              GetBuilder<FavoriteViewController>(
                builder: (controller) {
                  return Handlingdataviwe(
                    statusrequest: controller.statusrequest,
                    widget: Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.favoritesByPlatform.keys.length,
                        itemBuilder: (context, index) {
                          String platform = controller.favoritesByPlatform.keys
                              .elementAt(index);
                          List<Product> favorites =
                              controller.favoritesByPlatform[platform]!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),

                              Row(
                                children: [CustLabelContainer(text: platform)],
                              ),

                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 15.w,
                                      mainAxisSpacing: 15.h,
                                      mainAxisExtent: 320.h,
                                    ),
                                itemCount: favorites.length,
                                itemBuilder: (context, gridIndex) {
                                  Product favorite = favorites[gridIndex];
                                  return InkWell(
                                    onTap: () {
                                      controller.goToProductDetails(
                                        title: favorite.productTitle!,
                                        platform: platform,
                                        asin: favorite.productId!,
                                        langamazon: enOrArAmazon(),
                                        lang: enOrAr(),
                                        productId: favorite.productId,
                                        goodsid: favorite.productId!,
                                        categoryid: favorite.categoryId,
                                        goodssn: favorite.goodsSn,
                                        langShein: enOrArShein(),
                                      );
                                    },
                                    child: Custgridviwe(
                                      image: CachedNetworkImage(
                                        imageUrl:
                                            secureUrl(favorite.productImage!) ??
                                            '',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        placeholder: (context, url) =>
                                            const Loadingimage(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      title: favorite.productTitle!,
                                      price: currencyService
                                          .convertAndFormatRange(
                                            priceText:
                                                favorite.productPrice
                                                    ?.toString() ??
                                                '0',
                                            from: 'USD',
                                          ),
                                      icon: IconButton(
                                        onPressed: () {
                                          controller.removeFavorite(
                                            favorite.productId!,
                                          );
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Appcolor.reed,
                                        ),
                                      ),
                                      discprice: '',
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

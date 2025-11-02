import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorite_view_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/fix_url.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteViewController());
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          PositionedAppBar(title: "Favorites All", onPressed: Get.back),
          Column(
            children: [
              SizedBox(height: 110.h),
              GetBuilder<FavoriteViewController>(
                builder: (controller) {
                  if (controller.statusrequest == Statusrequest.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.statusrequest ==
                      Statusrequest.failuer) {
                    return const Center(
                      child: Text('Failed to load favorites'),
                    );
                  } else if (controller.favorites.isEmpty) {
                    return const Center(child: Text('No favorite items yet!'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.favoritesByPlatform.keys.length,
                        itemBuilder: (context, index) {
                          String platform = controller.favoritesByPlatform.keys
                              .elementAt(index);
                          List<FavoriteModel> favorites =
                              controller.favoritesByPlatform[platform]!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [CustLabelContainer(text: platform)],
                              ),

                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 260,
                                    ),
                                itemCount: favorites.length,
                                itemBuilder: (context, gridIndex) {
                                  FavoriteModel favorite = favorites[gridIndex];
                                  return InkWell(
                                    onTap: () {
                                      controller.goToProductDetails(
                                        title: favorite.productTitle!,
                                        platform: platform,
                                        asin: favorite.productId!,
                                        langamazon: enOrArAmazon(),
                                        lang: enOrAr(),
                                        productId: int.tryParse(
                                          favorite.productId!.toString(),
                                        )!,
                                        goodsid: favorite.productId!.toString(),
                                        categoryid: favorite.categoryId
                                            .toString(),
                                        goodssn: favorite.goodsSn.toString(),
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
                                      disc: favorite.productPrice!,
                                      title: favorite.productTitle!,
                                      price: favorite.productPrice!,
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

                                  // ProductCard(
                                  //   favorite: favorite,
                                  //   onDelete: () => controller.removeFavorite(
                                  //     favorite.productId!,
                                  //   ),
                                  // );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

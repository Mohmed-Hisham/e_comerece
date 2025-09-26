import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorite_view_platform_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesAliexpries extends StatelessWidget {
  const FavoritesAliexpries({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteViewPlatformControllerImpl());
    return Scaffold(
      // appBar: AppBar(title: Text("Favorites Aliexpries")),
      body: GetBuilder<FavoriteViewPlatformControllerImpl>(
        builder: (controller) => RefreshIndicator(
          onRefresh: () async =>
              controller.getFavoritesPlatform(platform: controller.platform),
          child: Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(
                title: "Favorites ${controller.platform}",
                onPressed: Get.back,
              ),
              Handlingdataviwe(
                // shimmer: ShimmerGrideviwe(forSilver: true),
                statusrequest: controller.statusrequest,
                widget: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(""),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        itemCount: controller.favorites.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 260,
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.favorites[index];
                          return InkWell(
                            onTap: () => controller.goToProductDetails(
                              int.parse(item.productId!.toString()),
                              enOrAr(),
                              item.productTitle!,
                            ),
                            child: Custgridviwe(
                              image: CachedNetworkImage(
                                imageUrl: 'https:${item.productImage}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) =>
                                    const Center(child: ShimmerImageProduct()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              disc: item.productPrice!,
                              title: item.productTitle!,
                              price: item.productPrice!,
                              icon: IconButton(
                                onPressed: () =>
                                    controller.removeFavorite(item.productId!),

                                icon: Icon(
                                  Icons.favorite_rounded,
                                  color: Appcolor.primrycolor,
                                ),
                              ),
                              discprice: item.productPrice!,
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

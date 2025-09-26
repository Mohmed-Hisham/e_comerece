import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/searchbyimage_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/aliexpress/categoryList_for_imagesearch.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchByImageView extends StatelessWidget {
  const SearchByImageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SearchByimageControllerllerImple());
    Get.put(FavoritesController());
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),

          GetBuilder<SearchByimageControllerllerImple>(
            builder: (controller) {
              return Handlingdataviwe(
                statusrequest: controller.statusrequest,
                widget: Column(
                  children: [
                    SizedBox(height: 80),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Appcolor.primrycolor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(controller.image!.path),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: SizedBox(
                                    child: Custombuttonauth(
                                      inputtext: "البحث مجددا",
                                      onPressed: () {
                                        controller.pickimage();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 130,
                              child: CategorylistForImagesearch(
                                controller: controller,
                              ),
                            ),

                            _buildProductList(controller),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          PositionedAppBar(title: "Search By Image", onPressed: Get.back),
        ],
      ),
    );
  }

  Widget _buildProductList(SearchByimageControllerllerImple controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 260,
      ),
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        final item = controller.items[index].item!;

        return InkWell(
          onTap: () {
            int id = int.tryParse(item.itemId!.toString()) ?? 0;
            controller.gotoditels(id: id, lang: enOrAr());
          },

          child: Custgridviwe(
            image: CachedNetworkImage(
              imageUrl: "https:${item.image!}",
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            disc: "${item.sku!.def!.promotionPrice} \$",
            title: item.title!,
            price: "${item.sku!.def!.promotionPrice} \$",
            icon: GetBuilder<FavoritesController>(
              builder: (isFavoriteController) {
                bool isFav =
                    isFavoriteController.isFavorite[item.itemId] ?? false;

                return IconButton(
                  onPressed: () {
                    isFavoriteController.toggleFavorite(
                      item.itemId!.toString(),
                      item.title!,
                      item.image!,
                      "\$${item.sku!.def!.price}",
                      "Aliexpress",
                    );
                  },
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.black,
                    size: 25,
                  ),
                );
              },
            ),
            discprice: "${item.sku!.def!.promotionPrice} \$",
            countsall: "${item.sales!} مبيعة",
          ),
        );
      },
    );
  }
}

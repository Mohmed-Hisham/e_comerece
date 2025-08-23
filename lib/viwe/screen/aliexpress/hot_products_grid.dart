import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/category_controller.dart';
import 'package:e_comerece/controller/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotProductsGrid extends GetView<HomePageControllerImpl> {
  const HotProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // final HomePageControllerImpl controller = Get.find();

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: controller.hotProducts.length,
      itemBuilder: (context, index) {
        final product = controller.hotProducts[index];

        return InkWell(
          onTap: () {
            String id = product.productId.toString();
            controller.gotoditels(id);
          },
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: product.productMainImageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productTitle!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${product.targetSalePrice!}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${product.targetOriginalPrice}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // if (product.discount != "0%")
                          //   Text(
                          //     product.discount!,
                          //     style: const TextStyle(
                          //       fontSize: 16,
                          //       color: Colors.grey,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          GetBuilder<FavoritesController>(
                            builder: (controller) {
                              bool isFav =
                                  controller.isFavorite[product.productId
                                      .toString()] ??
                                  false;

                              return IconButton(
                                onPressed: () {
                                  controller.toggleFavorite(
                                    product.productId!.toString(),
                                    product.productTitle!,
                                    product.productMainImageUrl!,
                                    product.targetSalePrice!,
                                    "aliex",
                                  );
                                },
                                // 2. نستخدم الحالة لتحديد شكل ولون الأيقونة
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFav ? Colors.red : Colors.grey,
                                  size: 30, // يمكنك تعديل الحجم
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

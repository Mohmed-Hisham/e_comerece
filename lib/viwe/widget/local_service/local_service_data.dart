import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/local_service/local_service_controller.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LocalServiceData extends GetView<LocalServiceController> {
  const LocalServiceData({super.key});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      isSliver: true,
      statusrequest: controller.fetchstatusrequest,
      widget: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          mainAxisExtent: 330.h,
        ),

        itemCount: controller.services.length,
        itemBuilder: (context, index) {
          final product = controller.services[index];

          return InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutesname.localServiceDetails,
                arguments: {'service': product},
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Custgridviwe(
                image: Hero(
                  tag: product.serviceId!,
                  child: CustomCachedImage(
                    imageUrl:
                        "https://res.cloudinary.com/dgonvbimk/image/upload/v1766790189/pg0ne5gqx5hwyk7uyxhj.jpg",
                  ),
                ),
                disc: product.serviceName!,

                title: product.serviceName!,
                price: product.servicePrice.toString(),
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav = false;
                    //     controller.isFavorite[product.productAsin.toString()] ??
                    //     false;

                    return IconButton(
                      onPressed: () {
                        // controller.toggleFavorite(
                        //   product.productAsin.toString(),
                        //   product.dealTitle.toString(),
                        //   product.dealPhoto.toString(),
                        //   product.dealPrice?.amount ?? "",
                        //   "Amazon",
                        // );
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

                discprice: product.servicePrice.toString(),
                // countsall: product.serviceBadge.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/our_products/our_product_details_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/bottom_add_to_cart_bar.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/product_description_section.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/product_image_carousel.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/product_info_section.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/related_products_section.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OurProductDetailsView extends StatefulWidget {
  const OurProductDetailsView({super.key});

  @override
  State<OurProductDetailsView> createState() => _OurProductDetailsViewState();
}

class _OurProductDetailsViewState extends State<OurProductDetailsView> {
  late OurProductDetailsController detailsController;
  final currencyService = Get.find<CurrencyService>();
  late final String _tag;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    final productId = args?['product']?.id ?? args?['productid'] ?? '';
    _tag =
        'product_detail_${productId}_${DateTime.now().millisecondsSinceEpoch}';
    detailsController = Get.put(OurProductDetailsController(), tag: _tag);
  }

  @override
  void dispose() {
    Get.delete<OurProductDetailsController>(tag: _tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.white2,
      body: GetBuilder<OurProductDetailsController>(
        tag: _tag,
        builder: (controller) {
          return Stack(
            children: [
              const PositionedRight1(),
              const PositionedRight2(),
              ListView(
                controller: controller.scrollController,
                children: [
                  if (controller.pageStatus == Statusrequest.loading)
                    SizedBox(height: 250.h),
                  Handlingdataviwe(
                    isSizedBox: true,
                    statusrequest: controller.pageStatus,
                    widget: controller.product == null
                        ? const SizedBox()
                        : _buildBody(controller.product!),
                  ),
                ],
              ),
              GetBuilder<OurProductDetailsController>(
                tag: _tag,
                id: 'productInfo',
                builder: (controller) {
                  return BottomAddToCartBar(
                    onToggleFavorite: GetBuilder<FavoritesController>(
                      builder: (favController) {
                        final productId =
                            controller.product?.id?.toString() ?? "";
                        bool isFav =
                            favController.isFavorite[productId] ?? false;

                        return IconButton(
                          onPressed: () {
                            favController.toggleFavorite(
                              productId,
                              controller.product?.title ?? "",
                              controller.product?.mainImage ?? "",
                              (controller.product?.discountPrice ??
                                      controller.product?.price ??
                                      0)
                                  .toString(),
                              "LocalProduct",
                              categoryid: controller.product?.categoryId
                                  ?.toString(),
                            );
                          },
                          icon: FaIcon(
                            isFav
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: Appcolor.reed,
                            size: 22.sp,
                          ),
                        );
                      },
                    ),
                    quantity: controller.quantity,
                    onIncrement: controller.increment,
                    onDecrement: controller.decrement,
                    onAddToCart: () =>
                        controller.onAddToCart(controller.selectedAttributes),
                    isLoading: controller.isInfoLoading,
                    buttonState: controller.cartButtonState,
                  );
                },
              ),
              PositionedAppBar(
                title: StringsKeys.productDetails.tr,
                onPressed: Get.back,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(LocalProductModel product) {
    return _buildContent(product);
  }

  Widget _buildContent(LocalProductModel product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 100.h),
        ProductImageCarousel(product: product),
        SizedBox(height: 20.h),
        ProductInfoSection(product: product, currencyService: currencyService),
        SizedBox(height: 16.h),
        if (product.description != null && product.description!.isNotEmpty)
          ProductDescriptionSection(description: product.description!),
        RelatedProductsSection(currencyService: currencyService, tag: _tag),
        SizedBox(height: 150.h),
      ],
    );
  }
}

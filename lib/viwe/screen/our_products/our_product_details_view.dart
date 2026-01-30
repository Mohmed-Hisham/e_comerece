import 'package:e_comerece/controller/our_products/our_product_details_controller.dart';
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
import 'package:get/get.dart';

class OurProductDetailsView extends StatefulWidget {
  const OurProductDetailsView({super.key});

  @override
  State<OurProductDetailsView> createState() => _OurProductDetailsViewState();
}

class _OurProductDetailsViewState extends State<OurProductDetailsView> {
  late LocalProductModel product;
  late OurProductDetailsController detailsController;
  int quantity = 1;
  final currencyService = Get.find<CurrencyService>();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    product = args?['product'] as LocalProductModel;
    detailsController = Get.put(OurProductDetailsController());
  }

  void _incrementQuantity() {
    if (product.stockQuantity == null || quantity < product.stockQuantity!) {
      setState(() => quantity++);
    }
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() => quantity--);
    }
  }

  void _addToCart() {
    Get.snackbar(
      "success",
      StringsKeys.addedToCart.tr,
      backgroundColor: Appcolor.primrycolor,
      colorText: Appcolor.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.white2,
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          _buildContent(),
          _buildAppBar(),
          BottomAddToCartBar(
            product: product,
            quantity: quantity,
            onIncrement: _incrementQuantity,
            onDecrement: _decrementQuantity,
            onAddToCart: _addToCart,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        SizedBox(height: 100.h),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImageCarousel(product: product),
                SizedBox(height: 20.h),
                ProductInfoSection(
                  product: product,
                  currencyService: currencyService,
                ),
                SizedBox(height: 16.h),
                if (product.description != null &&
                    product.description!.isNotEmpty)
                  ProductDescriptionSection(description: product.description!),
                RelatedProductsSection(currencyService: currencyService),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return PositionedAppBar(
      title: StringsKeys.productDetails.tr,
      onPressed: () => Get.back(),
    );
  }
}

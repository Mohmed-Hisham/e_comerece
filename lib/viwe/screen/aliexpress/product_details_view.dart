import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/viwe/widget/aliexpress/add_to_cart_bottom_sheet.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custattribute_selection.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custmedia_carousel.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custpackage_info.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custstock_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsController());
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ProductDetailsController>(
          builder: (controller) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.primrycolor,
              foregroundColor: Appcolor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Get.bottomSheet(
                AddToCartBottomSheet(controller: controller),
                backgroundColor: Colors.white,
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              );
            },
            child: Text("add to cart"),
          ),
        ),
      ),
      appBar: AppBar(title: const Text('Product Details')),
      body: GetBuilder<ProductDetailsController>(
        builder: (controller) {
          return Handlingdataviwe(
            statusrequest: controller.statusrequest,
            widget: SingleChildScrollView(
              child: _buildProductDetails(context, controller),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: const Text('Add to Cart'),
      //   icon: const Icon(Icons.shopping_cart),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustmediaCarousel(controller: controller),
        // _buildMediaCarousel(controller),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductTitle(context, controller),
              const SizedBox(height: 8),
              _buildSellerInfo(context, controller),
              const SizedBox(height: 16),
              _buildPriceDisplay(context, controller),
              const SizedBox(height: 16),
              CustattributeSelection(controller: controller),
              // _buildAttributeSelection(context, controller),
              const SizedBox(height: 16),
              Custpackageinfo(controller: controller),
              // _buildPackageInfo(context, controller),
              const SizedBox(height: 16),
              CuststockInfo(controller: controller),
              // _buildStockInfo(context, controller),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductTitle(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    final subject = controller.itemDetails?.productInfoComponent?.subject;
    if (subject == null) return const SizedBox.shrink();
    return Text(subject, style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _buildSellerInfo(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    final seller = controller.itemDetails?.sellerComponent;
    if (seller == null) return const SizedBox.shrink();
    return Row(
      children: [
        if (seller.storeLogo != null)
          CircleAvatar(
            backgroundImage: NetworkImage(seller.storeLogo!),
            radius: 20,
          ),
        const SizedBox(width: 8),
        if (seller.storeName != null)
          Expanded(
            child: Text(
              seller.storeName!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
      ],
    );
  }

  Widget _buildPriceDisplay(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    final price = controller.currentSku?.skuVal?.skuActivityAmount;
    if (price == null) return const SizedBox.shrink();
    return Text(
      price.formatedAmount!,
      style: Theme.of(
        context,
      ).textTheme.headlineMedium?.copyWith(color: Colors.red),
    );
  }
}

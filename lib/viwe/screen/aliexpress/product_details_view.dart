import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_product_details.dart';
import 'package:e_comerece/viwe/screen/aliexpress/add_to_cart_bottom_sheet.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custattribute_selection.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custmedia_carousel.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custpackage_info.dart';
import 'package:e_comerece/viwe/widget/aliexpress/custstock_info.dart';
import 'package:e_comerece/viwe/widget/aliexpress/productdescriptionhtml.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    print("build1");
    Get.put(ProductDetailsController());
    AddorrmoveControllerimple addcontroller = Get.put(
      AddorrmoveControllerimple(),
    );
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
              // Map<String, dynamic> cc = buildDisplayAttributes(controller);
              // print("  ${jsonEncode(buildDisplayAttributes(controller))}");
              // print(cc['Color']['name']);
              // print(cc['Color']['image']);
              // print(cc['Compatibility by Model']['name']);
              // print(cc['Compatibility by Model']['image']);
              // print(controller.productId.runtimeType);

              // print("controller.quantity=>${controller.quantity}");

              // controller.getquiqtity(
              //   jsonEncode(buildDisplayAttributes(controller)),
              // );
              // print(".quantity=>${controller.quantity}");
              Get.bottomSheet(
                AddToCartBottomSheet(
                  controller: controller,
                  addcontroller: addcontroller,
                ),
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
      // appBar: AppBar(title: const Text('Product Details')),
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),

          Container(
            padding: EdgeInsets.only(top: 65),
            child: GetBuilder<ProductDetailsController>(
              builder: (controller) {
                print("build2");
                return Handlingdataviwe(
                  shimmer: ShimmerProductDetails(),
                  statusrequest: controller.statusrequest,
                  widget: SingleChildScrollView(
                    child: _buildProductDetails(context, controller),
                  ),
                );
              },
            ),
          ),
          PositionedAppBar(title: "Product Details", onPressed: Get.back),
        ],
      ),
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    final html =
        controller.itemDetailsModel?.result?.item?.description?.html ?? '';
    final images = extractImageUrls(html);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(""),
        // const SizedBox(height: 20),
        CustmediaCarousel(controller: controller),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductTitle(context, controller),
              const SizedBox(height: 8),
               ImagesCarousel(images: images, height: 300),
                
                 const SizedBox(height: 8),
              _buildSellerInfo(context, controller),
              const SizedBox(height: 16),
              _buildPriceDisplay(context, controller),
              const SizedBox(height: 16),
              CustattributeSelection(controller: controller),
              const SizedBox(height: 16),
              Custpackageinfo(controller: controller),
              const SizedBox(height: 16),
              CuststockInfo(controller: controller),
              const SizedBox(height: 16),
              _buildReviews(context, controller),
              const SizedBox(height: 16),
              _buildSpecifications(context, controller),
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
    final subject = controller.subject;
    if (subject == null) return const SizedBox.shrink();
    return GetBuilder<AddorrmoveControllerimple>(
      id: 'fetchCart',
      builder: (cot) {
        bool isInCart = cot.isCart[controller.productId.toString()] ?? false;
        return Row(
          children: [
            Expanded(
              child: Text(
                subject,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (isInCart)
              const Icon(Icons.shopping_cart, color: Appcolor.primrycolor),
          ],
        );
      },
    );
  }

  Widget _buildSellerInfo(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    final sellerName = controller.sellerName;
    if (sellerName == null) return const SizedBox.shrink();
    return Row(
      children: [
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            sellerName,
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
    final originalPrice = controller.currentSku?.skuVal?.skuAmount;

    if (price == null && originalPrice == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (price != null)
          Text(
            price.formatedAmount!,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.red),
          ),
        const SizedBox(width: 8),
        if (originalPrice != null && price?.value != originalPrice.value)
          Text(
            originalPrice.formatedAmount!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }

  Widget _buildReviews(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    final count = controller.reviewsCount;
    final avg = controller.averageStar;
    if (count == null && avg == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        if (avg != null)
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                avg,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Appcolor.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        const SizedBox(width: 12),
        if (count != null)
          Text(
            '( $count reviews )',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  Widget _buildSpecifications(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    final specs = controller.specifications;
    if (specs.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Specifications', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ...specs.map((s) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      s.name ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Appcolor.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 35,
                      child: ListView(
                        scrollDirection: Axis.horizontal,

                        children: [
                          Text(
                            s.value!,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Appcolor.black2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Appcolor.gray, endIndent: 20, indent: 20),
            ],
          );
        }).toList(),
      ],
    );
  }
}

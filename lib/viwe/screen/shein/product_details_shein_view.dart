import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/shein/product_details_shein_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/screen/shein/product_from_details.dart';
import 'package:e_comerece/viwe/screen/shein/search_shein_viwe.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/shein/product_images_carousel_shein.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsSheinView extends StatelessWidget {
  const ProductDetailsSheinView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsSheinControllerImple());
    AddorrmoveControllerimple cartcontroller = Get.put(
      AddorrmoveControllerimple(),
    );

    return Scaffold(
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),

          Container(
            padding: const EdgeInsets.only(top: 65),
            child: GetBuilder<ProductDetailsSheinControllerImple>(
              builder: (controller) {
                log('build');
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo is ScrollUpdateNotification) {
                      if (scrollInfo.metrics.axis == Axis.vertical) {
                        if (!controller.isLoadingSearch) {
                          final atEdge = scrollInfo.metrics.atEdge;
                          final pixels = scrollInfo.metrics.pixels;
                          final maxScrollExtent =
                              scrollInfo.metrics.maxScrollExtent;
                          if (atEdge && pixels == maxScrollExtent) {
                            if (controller.isOneSearch) {
                              controller.searshProduct();
                              controller.isOneSearch = false;
                            } else {
                              controller.searshProduct(isLoadMore: true);
                            }
                          }
                        }
                      }
                    }
                    return true;
                  },

                  child: Handlingdataviwe(
                    isproductdetails: true,
                    ontryagain: () => controller.fetchProductDetails(),
                    statusrequest: controller.statusrequest,
                    widget: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildProductDetails(
                            context,
                            controller,
                            cartcontroller,
                          ),
                        ),

                        const SliverToBoxAdapter(
                          child: Row(
                            children: [
                              CustLabelContainer(text: 'Related Items'),
                            ],
                          ),
                        ),
                        const SliverSpacer(20),
                        ProductFromDetails(),
                        GetBuilder<ProductDetailsSheinControllerImple>(
                          id: 'searchProducts',
                          builder: (con) {
                            if (con.statusrequestsearch ==
                                Statusrequest.loading) {
                              return SliverToBoxAdapter(
                                child: ShimmerBar(
                                  height: 10,
                                  animationDuration: 1,
                                ),
                              );
                            } else {
                              return SliverToBoxAdapter(child: Container());
                            }
                          },
                        ),
                      ],
                    ),
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
    ProductDetailsSheinControllerImple controller,
    AddorrmoveControllerimple cartController,
  ) {
    log(controller.sizeAttributes.map((e) => e.attrName).toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        ProductImagesCarouselShein(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleRowShein(
                controller: controller,
                cartController: cartController,
              ),
              const SizedBox(height: 12),
              _PriceSectionShein(controller: controller),
              const SizedBox(height: 12),
              _VariantSelectorShein(controller: controller),
              const SizedBox(height: 16),
              _SizeTemplateSection(),
              const SizedBox(height: 16),
              _MallStockSectionShein(controller: controller),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              _QuantitySectionShein(controller: controller),
              const SizedBox(height: 16),
              _AddToCartButtonShein(
                controller: controller,
                cartController: cartController,
              ),
              const SizedBox(height: 16),
              // _SellerInfoShein(controller: controller),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _TitleRowShein extends StatelessWidget {
  final ProductDetailsSheinControllerImple controller;
  final AddorrmoveControllerimple cartController;
  const _TitleRowShein({
    required this.controller,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    final subject = controller.subject;
    if (subject == null) return const SizedBox.shrink();
    return GetBuilder<AddorrmoveControllerimple>(
      id: 'fetchCart',
      builder: (cot) {
        bool isInCart = cot.isCart[controller.goodssn.toString()] ?? false;
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
}

class _PriceSectionShein extends StatelessWidget {
  final ProductDetailsSheinControllerImple controller;
  const _PriceSectionShein({required this.controller});

  @override
  Widget build(BuildContext context) {
    final currentPrice = controller.getCurrentPrice();
    if (currentPrice == null) return const SizedBox.shrink();
    final total = currentPrice * math.max(1, controller.quantity);
    final formatted = controller.getCurrentPriceFormatted();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.primrycolor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Appcolor.primrycolor,
                ),
              ),
              Text(
                formatted,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Appcolor.primrycolor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total (${controller.quantity} ${controller.getUnitName()}):',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                total.toStringAsFixed(2),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Appcolor.primrycolor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VariantSelectorShein extends StatelessWidget {
  final ProductDetailsSheinControllerImple controller;
  const _VariantSelectorShein({required this.controller});

  @override
  Widget build(BuildContext context) {
    final variants = controller.variants;
    if (variants.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          children: [
            ...variants.map((v) {
              final img = v.originalImg ?? v.goodsThumb ?? v.goodsColorImage;
              final isSelected =
                  controller.currentVariant?.goodsId == v.goodsId;

              return InkWell(
                onTap: () {
                  controller.updateSelectedVariant(v);
                  // print('Selected variant: ${v.goodsSn}');
                  controller.goodssn = v.goodsSn ?? '';
                  controller.fetchImageListFromApi();
                  controller.getquiqtity(
                    '{"size":"${controller.label}", "model":"${controller.imageListFromApi.first.toString()}"}',
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? Appcolor.primrycolor
                          : Appcolor.threecolor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: img == null
                      ? const SizedBox.shrink()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            imageUrl: 'https:$img',

                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                ),
              );
            }),
          ],
        ),
        // SizedBox(
        //   height: 64,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (context, i) {
        //       final v = variants[i];
        //       final img = v.originalImg ?? v.goodsThumb ?? v.goodsColorImage;

        //       final isSelected =
        //           controller.currentVariant?.goodsId == v.goodsId;

        //     },
        //     separatorBuilder: (_, __) => const SizedBox(width: 10),
        //     itemCount: variants.length,
        //   ),
        // ),
      ],
    );
  }
}

class _MallStockSectionShein extends StatelessWidget {
  final ProductDetailsSheinControllerImple controller;
  const _MallStockSectionShein({required this.controller});

  @override
  Widget build(BuildContext context) {
    final malls = controller.activeMallList;
    if (malls.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.threecolor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Availability', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...malls.map(
            (m) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mall ${m.mallCode ?? ''}'),
                Text('${m.stock ?? 0} in stock'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantitySectionShein extends StatelessWidget {
  final ProductDetailsSheinControllerImple controller;
  const _QuantitySectionShein({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsSheinControllerImple>(
      id: 'quantity',
      builder: (_) {
        return Row(
          children: [
            IconButton(
              onPressed: controller.decrementQuantity,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              controller.quantity.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton(
              onPressed: controller.incrementQuantity,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        );
      },
    );
  }
}

class _AddToCartButtonShein extends StatelessWidget {
  final ProductDetailsSheinControllerImple controller;
  final AddorrmoveControllerimple cartController;
  const _AddToCartButtonShein({
    required this.controller,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsSheinControllerImple>(
      id: 'quantity',
      builder: (_) {
        final bool isInCart = controller.isInCart;
        final bool isAvailable = controller.isProductAvailable();
        return SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isAvailable
                ? () async {
                    await cartController.add(
                      controller.goodssn.toString(),
                      controller.subject.toString(),
                      controller.imageListFromApi.first.toString(),
                      controller.getCurrentPriceFormatted(),
                      'Shein',
                      controller.quantity.toString(),
                      '{"size":"${controller.label}", "model":"${controller.imageListFromApi.first.toString()}"}',
                      '1000',
                      tier: "",
                    );
                    controller.getquiqtity(
                      '{"size":"${controller.label}", "model":"${controller.imageListFromApi.first.toString()}"}',
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isInCart && controller.quantity != controller.cartquantityDB
                  ? Appcolor.soecendcolor
                  : isInCart
                  ? Appcolor.soecendcolor
                  : Appcolor.primrycolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isInCart && controller.quantity != controller.cartquantityDB
                      ? Icons.update
                      : isInCart
                      ? Icons.check
                      : Icons.shopping_cart,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  isInCart && controller.quantity != controller.cartquantityDB
                      ? 'Update Cart'
                      : isInCart
                      ? 'Added to Cart'
                      : 'Add to Cart',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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

// class _SellerInfoShein extends StatelessWidget {
//   final ProductDetailsSheinControllerImple controller;
//   const _SellerInfoShein({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final seller = controller.sellerName;
//     if (seller == null || seller.isEmpty) return const SizedBox.shrink();
//     return Row(
//       children: [
//         const Icon(Icons.store, color: Appcolor.primrycolor),
//         const SizedBox(width: 8),
//         Text(seller, style: Theme.of(context).textTheme.titleMedium),
//       ],
//     );
//   }
// }

// Widget buildvariants(
//   BuildContext context,
//   ProductDetailsSheinControllerImple controller,
// ) {
//   return ListView.builder(
//     itemCount:
//         controller.productDitelsSheinModel?.data?.products?.variants.length ??
//         0,

//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),

//     itemBuilder: (context, index) {
//       return Container();
//     },
//   );
// }

class _SizeTemplateSection extends StatelessWidget {
  const _SizeTemplateSection();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsSheinControllerImple>(
      id: 'Size',
      builder: (controller) {
        final sizes = controller.sizeAttributes;
        log('sizes: $sizes');
        if (sizes.isEmpty) return const SizedBox.shrink();

        final title = sizes.first.attrName ?? 'Attribute';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...sizes.map((attr) {
              final values = (attr.attrValueList)
                  .map((v) {
                    final id =
                        (v.attrValueId != null && v.attrValueId!.isNotEmpty)
                        ? v.attrValueId!
                        : (v.attrValue ?? '');
                    final label = v.attrValue ?? id;
                    return {'id': id, 'label': label};
                  })
                  .where((m) => (m['label'] as String).isNotEmpty)
                  .toList();

              if (values.isEmpty) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: values.map((m) {
                    final valueId = m['id'] as String;
                    final label = m['label'] as String;
                    final attrId = attr.attrId ?? 0;
                    final selected = controller.isSelectedValue(
                      attrId,
                      valueId,
                    );

                    return GestureDetector(
                      onTap: () {
                        // غيّر الاختيار في الكونترولر
                        controller.selectValue(attrId, valueId);
                        controller.label = label;
                        controller.getquiqtity(
                          '{"size":"${controller.label}", "model":"${controller.imageListFromApi.first.toString()}"}',
                        );
                        // اطبع القيمة المطلوبة
                        print(
                          'Selected value: $label (id: $valueId) for attr $attrId',
                        );
                        log(
                          " vvvvv ${controller.selectedAttributeValue.toString()}",
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Appcolor.primrycolor.withValues(alpha: 0.1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected
                                ? Appcolor.primrycolor
                                : Colors.grey.shade300,
                            width: selected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolor.primrycolor.withValues(
                                alpha: 0.05,
                              ),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          label,
                          style: selected
                              ? Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                )
                              : Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

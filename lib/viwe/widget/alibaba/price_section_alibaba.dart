import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/data/model/alibaba_model/product_ditels_alibaba_model.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceSectionAlibaba extends StatelessWidget {
  final String? tag;
  const PriceSectionAlibaba({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      tag: tag,
      id: 'quantity',
      builder: (controller) {
        final currencyService = Get.find<CurrencyService>();
        final currentPrice = controller.getCurrentPrice();
        final totalPrice = controller.getTotalPriceFormatted();
        final List<PriceList> priceList = controller.priceList;

        if (currentPrice == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Appcolor.primrycolor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Appcolor.primrycolor.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: priceList.length,
                itemBuilder: (context, index) {
                  final price = priceList[index];
                  String maxQuantity = '';

                  if (price.maxQuantity == -1) {
                    maxQuantity = StringsKeys.unlimited.tr;
                  } else {
                    maxQuantity = price.maxQuantity.toString();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringsKeys.price.tr,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Appcolor.primrycolor,
                                ),
                          ),
                          Text(
                            currencyService.convertAndFormat(
                              amount:
                                  double.tryParse(price.price.toString()) ??
                                  0.0,
                              from: 'USD',
                            ),
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Appcolor.primrycolor,
                                ),
                          ),
                        ],
                      ),

                      Text(
                        StringsKeys.quantityRange.trParams({
                          'min': price.minQuantity.toString(),
                          'max': maxQuantity,
                        }),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Appcolor.black2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsKeys.totalWithQuantity.trParams({
                      'quantity': controller.quantity.toString(),
                      'unit': controller.getUnitName(),
                    }),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    totalPrice,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Appcolor.primrycolor,
                    ),
                  ),
                ],
              ),
              Text(
                StringsKeys.priceWithAmount.trParams({
                  'price': currencyService.convertAndFormat(
                    amount: currentPrice,
                    from: 'USD',
                  ),
                }),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Appcolor.primrycolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

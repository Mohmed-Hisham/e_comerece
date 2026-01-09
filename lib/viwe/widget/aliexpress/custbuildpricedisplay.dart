import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Custbuildpricedisplay extends StatelessWidget {
  final String? tag;
  const Custbuildpricedisplay({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsControllerImple>(
      tag: tag,
      id: 'selectedAttributes',
      builder: (controller) {
        final price = controller.currentSku?.skuVal?.skuActivityAmount;
        final originalPrice = controller.currentSku?.skuVal?.skuAmount;
        final currencyService = Get.find<CurrencyService>();

        return Row(
          children: [
            if (price != null && price.value != null)
              Text(
                currencyService.convertAndFormat(
                  amount: price.value!,
                  from: 'USD',
                ),
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.red),
              ),
            const SizedBox(width: 8),
            if (originalPrice != null &&
                originalPrice.value != null &&
                price?.value != originalPrice.value)
              Text(
                currencyService.convertAndFormat(
                  amount: originalPrice.value!,
                  from: 'USD',
                ),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
          ],
        );
      },
    );
  }
}

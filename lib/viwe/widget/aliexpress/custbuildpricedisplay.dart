import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

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
      },
    );
  }
}

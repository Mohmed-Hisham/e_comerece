import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantitySectionAlibaba extends StatelessWidget {
  final String? tag;
  const QuantitySectionAlibaba({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      tag: tag,
      id: 'quantity',
      builder: (controller) {
        final minQuantity = controller.getMinQuantity();

        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringsKeys.quantity.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      StringsKeys.minQuantityLabel.trParams({
                        'min': minQuantity.toString(),
                      }),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Appcolor.black2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: controller.quantity > minQuantity
                            ? Appcolor.primrycolor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: controller.quantity > minQuantity
                            ? controller.decrementQuantity
                            : null,
                        icon: const Icon(Icons.remove, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          '${controller.quantity} ${controller.getUnitName()}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Appcolor.primrycolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: controller.incrementQuantity,
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 10; i <= 2000; i += 10)
                      InkWell(
                        onTap: () {
                          controller.incrementQuantity(pressedCount: i);
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: controller.quantity == i
                                ? Appcolor.primrycolor.withValues(alpha: 0.2)
                                : Colors.transparent,
                            border: Border.all(
                              color: controller.quantity == i
                                  ? Appcolor.primrycolor
                                  : Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$i',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  color: controller.getMinQuantity() > i
                                      ? Appcolor.gray
                                      : Appcolor.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }
}

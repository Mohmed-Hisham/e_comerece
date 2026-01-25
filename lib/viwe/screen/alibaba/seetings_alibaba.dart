import 'package:e_comerece/controller/alibaba/product_alibaba_home_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeetingsAlibaba extends GetView<ProductAlibabaHomeControllerImp> {
  const SeetingsAlibaba({super.key});

  @override
  Widget build(BuildContext context) {
    final startPrice = controller.settings?.startPrice;
    final endPrice = controller.settings?.endPrice;

    final startPriceText = (startPrice == null || startPrice.isEmpty)
        ? StringsKeys.startPriceRandom.tr
        : "${StringsKeys.startPriceLabel.tr} $startPrice";

    final endPriceText = (endPrice == null || endPrice.isEmpty)
        ? StringsKeys.endPriceRandom.tr
        : "${StringsKeys.endPriceLabel.tr} $endPrice";

    List<String> list = [startPriceText, endPriceText];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: Row(
        children: [
          ...List.generate(list.length, (index) {
            return Container(
              width: 100,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Appcolor.primrycolor, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                list[index],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Appcolor.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            );
          }),
          const Spacer(),
          CustButtonBotton(
            onTap: () {
              Get.dialog(
                AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      children: [
                        Text(
                          StringsKeys.priceFilterNote.tr,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 12),
                        Custtextfeld(
                          hint: StringsKeys.startPrice.tr,
                          controller: controller.startprice,
                        ),
                        Custtextfeld(
                          hint: StringsKeys.endPrice.tr,
                          controller: controller.endprice,
                        ),

                        CustButtonBotton(
                          onTap: () {
                            controller.searshText(
                              q: controller.searchController.text,
                              endPrice: controller.endprice.text,
                              startPrice: controller.startprice.text,
                            );
                            Get.back();
                          },
                          title: StringsKeys.change.tr,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            title: StringsKeys.change.tr,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

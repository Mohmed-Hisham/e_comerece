import 'package:e_comerece/controller/amazon_controllers/amazon_home_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeetingsPriceShein extends GetView<AmazonHomeControllerImpl> {
  const SeetingsPriceShein({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: Row(
        // scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(2, (index) {
            return Container(
              width: 100,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Appcolor.primrycolor, width: 3),
                // color: Appcolor.black2,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                index == 0
                    ? (controller.startPriceController.text == '')
                          ? 'startPrice: random'
                          : 'startPrice: ${controller.startPriceController.text}'
                    : (controller.endPriceController.text == '')
                    ? ' endPrice: random'
                    : 'endPrice: ${controller.endPriceController.text}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Appcolor.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            );
          }),
          Spacer(),
          CustButtonBotton(
            onTap: () {
              Get.dialog(
                AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      spacing: 10,

                      children: [
                        Text(
                          "Note: Price filter is in USD and not related to your selected display currency.",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 12),
                        Custtextfeld(
                          hint: 'startPrice'.tr,
                          controller: controller.startPriceController,
                        ),
                        Custtextfeld(
                          hint: 'endPrice'.tr,
                          controller: controller.endPriceController,
                        ),

                        CustButtonBotton(
                          onTap: () {
                            controller.searshText();
                            Get.back();
                          },
                          title: "change".tr,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            title: "change".tr,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

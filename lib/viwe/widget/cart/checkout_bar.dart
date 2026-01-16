import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/helper/circular_widget.dart';
import 'package:e_comerece/core/shared/widget_shared/cust_button_botton.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(CartControllerImpl());
    final currencyService = Get.find<CurrencyService>();
    return GetBuilder<CartControllerImpl>(
      id: "1",
      builder: (controller) => Container(
        width: double.infinity,
        height: 180.h,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Appcolor.fourcolor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 55.h),
                    child: TextFormField(
                      focusNode: controller.couponFocusNode,
                      controller: controller.couponController,
                      decoration: InputDecoration(
                        isDense: true,
                        errorMaxLines: 2,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Appcolor.primrycolor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Appcolor.primrycolor,
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Appcolor.primrycolor,
                            width: 2,
                          ),

                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: StringsKeys.couponCode.tr,
                        labelStyle: TextStyle(
                          color: Appcolor.primrycolor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),

                GetBuilder<CartControllerImpl>(
                  id: 'coupon',
                  builder: (couponController) {
                    if (couponController.couPonstatusrequest ==
                        Statusrequest.loading) {
                      return loadingWidget();
                    } else {
                      return CustButtonBotton(
                        onTap: () {
                          controller.checkCoupon();
                        },
                        title: StringsKeys.apply.tr,
                      );
                    }
                  },
                ),
                IconButton(
                  onPressed: () {
                    diloginfo();
                  },
                  icon: Icon(Icons.quiz_outlined, color: Appcolor.primrycolor),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '${StringsKeys.total.tr}: ',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.black,
                        ),
                        children: [
                          TextSpan(
                            text: currencyService.convertAndFormat(
                              amount: controller.totalbuild,
                              from: 'USD',
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.black,
                              fontFamily: "asian",
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (controller.discount != null)
                      Text(
                        currencyService.convertAndFormat(
                          amount: controller.total() + controller.discount!,
                          from: 'USD',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                          decorationThickness: 2.0,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    controller.goTOCheckout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.primrycolor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    StringsKeys.checkout.tr,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void diloginfo() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringsKeys.howCouponWorks.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              StringsKeys.couponExplanation.tr,
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text(StringsKeys.okay.tr),
            ),
          ],
        ),
      ),
    ),
  );
}

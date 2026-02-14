import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
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
    final currencyService = Get.find<CurrencyService>();
    return GetBuilder<CartControllerImpl>(
      id: "1",
      builder: (controller) => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Appcolor.fourcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Coupon Row ──
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: TextFormField(
                      focusNode: controller.couponFocusNode,
                      controller: controller.couponController,
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        prefixIcon: Icon(
                          Icons.local_offer_outlined,
                          color: Appcolor.primrycolor,
                          size: 20.sp,
                        ),
                        hintText: StringsKeys.couponCode.tr,
                        hintStyle: TextStyle(
                          color: Appcolor.primrycolor.withValues(alpha: 0.6),
                          fontSize: 14.sp,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: const BorderSide(
                            color: Appcolor.primrycolor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: Appcolor.primrycolor.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GetBuilder<CartControllerImpl>(
                  id: 'coupon',
                  builder: (couponController) {
                    if (couponController.couPonstatusrequest ==
                        Statusrequest.loading) {
                      return loadingWidget();
                    }
                    return CustButtonBotton(
                      onTap: () => controller.checkCoupon(),
                      title: StringsKeys.apply.tr,
                    );
                  },
                ),
                SizedBox(width: 2.w),
                InkWell(
                  onTap: () => _showCouponInfoDialog(),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Icon(
                      Icons.help_outline_rounded,
                      color: Appcolor.primrycolor,
                      size: 22.sp,
                    ),
                  ),
                ),
              ],
            ),

            // ── Divider ──
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Divider(
                height: 1,
                color: Appcolor.primrycolor.withValues(alpha: 0.15),
              ),
            ),

            // ── Total & Checkout Row ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Price column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Old price (strikethrough)
                      if (controller.discountAmount != null)
                        Text(
                          currencyService.convertAndFormat(
                            amount: controller.getSubtotal(),
                            from: 'USD',
                          ),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.grey.shade400,
                            decorationThickness: 1.5,
                          ),
                        ),
                      // Total
                      Row(
                        children: [
                          Text(
                            '${StringsKeys.total.tr}: ',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Appcolor.black,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              currencyService.convertAndFormat(
                                amount: controller.totalbuild,
                                from: 'USD',
                              ),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Appcolor.black,
                                fontFamily: "asian",
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      // Discount badge
                      if (controller.discountAmount != null &&
                          controller.discountPercentage != null)
                        Container(
                          margin: EdgeInsets.only(top: 4.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            "${StringsKeys.discount.tr}: ${controller.discountPercentage!.toInt()}%",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                // Checkout button
                ElevatedButton(
                  onPressed: () => controller.goTOCheckout(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.primrycolor,
                    elevation: 2,
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        StringsKeys.checkout.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ],
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

void _showCouponInfoDialog() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Appcolor.primrycolor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_offer_rounded,
                color: Appcolor.primrycolor,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              StringsKeys.howCouponWorks.tr,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              StringsKeys.couponExplanation.tr,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.primrycolor,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  StringsKeys.okay.tr,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

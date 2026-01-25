import 'package:e_comerece/controller/CheckOut/checkout_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/helper/circular_widget.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/checkout/checkout_location_card.dart';
import 'package:e_comerece/viwe/widget/checkout/checkout_price_breakdown_card.dart';
import 'package:e_comerece/viwe/widget/checkout/checkout_summary_card.dart';
import 'package:e_comerece/viwe/widget/checkout/checkout_widgets.dart';
import 'package:e_comerece/viwe/widget/checkout/checkout_note_widgets.dart';
import 'package:e_comerece/viwe/widget/checkout/review_fee_card.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckOutControllerImpl>(
        init: CheckOutControllerImpl(),
        builder: (controller) {
          return Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(
                title: StringsKeys.checkout.tr,
                onPressed: () => Get.back(),
              ),
              Column(
                children: [
                  SizedBox(height: 110.h),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CheckoutSummaryCard(),
                          const Divider(thickness: 1, height: 1),
                          const CheckoutLocationCard(),
                          const Divider(thickness: 1, height: 1),
                          const TipsSection(),
                          const Divider(thickness: 1, height: 1),
                          const ReviewFeeCard(),
                          const CheckoutPriceBreakdownCard(),
                          const Divider(thickness: 1, height: 1),
                          const OrderNoteSection(),
                          const Divider(thickness: 1, height: 1),
                          const PaymentInfoNotice(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  _buildBottomBar(controller, context),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(
    CheckOutControllerImpl controller,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsKeys.totalPrice.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                GetBuilder<CheckOutControllerImpl>(
                  id: 'breakdown',
                  builder: (ctl) => Text(
                    Get.find<CurrencyService>().convertAndFormat(
                      amount: ctl.getFinalTotal(),
                      from: 'USD',
                    ),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.statusrequest == Statusrequest.loading) {
                      return;
                    }
                    controller.placeOrder();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.primrycolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Handlingdataviwe(
                    statusrequest: controller.statusrequest,
                    shimmer: loadingWidget(color: Appcolor.white),
                    widget: Text(
                      StringsKeys.placeOrder.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

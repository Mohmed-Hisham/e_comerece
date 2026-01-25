import 'package:e_comerece/controller/CheckOut/checkout_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TipsSection extends GetView<CheckOutControllerImpl> {
  const TipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringsKeys.tipsAppreciateTitle.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.black,
                      ),
                    ),
                    Text(
                      StringsKeys.tipsAppreciateBody.tr,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.volunteer_activism,
                color: Colors.orange,
                size: 28,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          GetBuilder<CheckOutControllerImpl>(
            id: 'tips',
            builder: (controller) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTipChip(10, controller),
                    _buildTipChip(15, controller),
                    _buildTipChip(20, controller),
                    _buildTipChip(30, controller),
                    _buildTipChip(
                      null,
                      controller,
                      label: StringsKeys.customTip.tr,
                    ),
                  ],
                ),
                if (controller.isCustomTipInputVisible) ...[
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.customTipController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            hintText: StringsKeys.enterAmountUSD.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.orange,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 10.h,
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      ElevatedButton(
                        onPressed: () => controller.applyCustomTip(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.primrycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                        ),
                        child: Text(
                          StringsKeys.apply.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipChip(
    double? amount,
    CheckOutControllerImpl controller, {
    String? label,
  }) {
    bool isSelected;
    if (amount != null) {
      isSelected = controller.selectedTip == amount;
    } else {
      // Custom Chip logic validation
      isSelected =
          controller.isCustomTipInputVisible ||
          (controller.selectedTip > 0 &&
              ![10.0, 15.0, 20.0, 30.0].contains(controller.selectedTip));
    }

    return GestureDetector(
      onTap: () {
        if (amount != null) {
          controller.updateTip(amount);
          if (controller.isCustomTipInputVisible) {
            controller.toggleCustomTipInput();
          }
        } else {
          controller.toggleCustomTipInput();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[400]!,
          ),
        ),
        child: Text(
          label ?? "\$${amount!.toInt()}",
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}

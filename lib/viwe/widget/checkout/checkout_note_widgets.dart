import 'package:e_comerece/controller/CheckOut/checkout_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderNoteSection extends StatelessWidget {
  const OrderNoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    // CheckOutControllerImpl should be registered
    final controller = Get.find<CheckOutControllerImpl>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsKeys.orderNote.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
          SizedBox(height: 10.h),
          TextFormField(
            controller: controller.noteController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: StringsKeys.orderNoteHint.tr,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.1),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 15.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentInfoNotice extends StatelessWidget {
  const PaymentInfoNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: Colors.blue, size: 20.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                StringsKeys.paymentNotice.tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.blue[900],
                  height: 1.5,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

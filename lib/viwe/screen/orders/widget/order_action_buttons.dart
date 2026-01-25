import 'package:e_comerece/controller/orders/order_details_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderActionButtons extends StatelessWidget {
  const OrderActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsControllerImp>(
      builder: (controller) {
        final canCancel = controller.canCancelOrder();

        if (!canCancel) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: _buildButton(
                onPressed: controller.isCancelling
                    ? null
                    : () => controller.cancelOrder(),
                loading: controller.isCancelling,
                icon: Icons.cancel_outlined,
                label: controller.isCancelling
                    ? StringsKeys.cancelling.tr
                    : StringsKeys.cancelOrder.tr,
                color: Appcolor.reed,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton({
    required VoidCallback? onPressed,
    required bool loading,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: loading
          ? SizedBox(
              width: 20.w,
              height: 20.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Icon(icon),
      label: Text(
        label,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }
}

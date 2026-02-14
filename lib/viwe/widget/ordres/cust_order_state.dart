import 'package:e_comerece/controller/orders/orders_controllre.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustStateOrders extends StatelessWidget {
  const CustStateOrders({super.key});

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.hourglass_top_rounded;
      case OrderStatus.actionRequired:
        return Icons.notification_important_rounded;
      case OrderStatus.processing:
        return Icons.settings_rounded;
      case OrderStatus.shipped:
        return Icons.local_shipping_rounded;
      case OrderStatus.completed:
        return Icons.check_circle_rounded;
      case OrderStatus.cancelled:
        return Icons.cancel_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersControllreImp>(
      builder: (controller) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          controller: controller.scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: OrderStatus.values.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final status = OrderStatus.values[index];
            final isSelected = controller.orderStatus == status;
            return GestureDetector(
              onTap: () {
                controller.orderStatus = status;
                controller.update();
                controller.getOrders();

                if (controller.scrollController.hasClients) {
                  final double target = index * 100.w;
                  final max =
                      controller.scrollController.position.maxScrollExtent;
                  final min =
                      controller.scrollController.position.minScrollExtent;
                  final clampedTarget = target.clamp(min, max);
                  controller.scrollController.animateTo(
                    clampedTarget,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: isSelected ? Appcolor.primrycolor : Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Appcolor.primrycolor.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(status),
                      size: 16.sp,
                      color: isSelected ? Colors.white : Appcolor.gray,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      controller.getStatusTitle(status),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected ? Colors.white : Appcolor.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

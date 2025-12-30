import 'package:e_comerece/controller/orders/orders_controllre.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustStateOrders extends StatelessWidget {
  const CustStateOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersControllreImp>(
      builder: (controller) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          controller: controller.scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: OrderStatus.values.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final status = OrderStatus.values[index];
            return GestureDetector(
              onTap: () {
                controller.orderStatus = status;
                controller.update();
                controller.getOrders();

                // Calculate scroll position only when tapping, after controller is attached
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
              child: Container(
                width: 120.w,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  color: Appcolor.white,
                  borderRadius: BorderRadius.circular(17.r),
                  border: Border.all(
                    color: controller.orderStatus == status
                        ? Appcolor.primrycolor
                        : Appcolor.black,
                    width: 2.w,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        controller.getStatusTitle(status),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
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

import 'package:e_comerece/controller/orders/orders_controllre.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/sliver_spacer.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/ordres/cust_order_state.dart';
import 'package:e_comerece/viwe/widget/ordres/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrdersControllreImp());
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          PositionedAppBar(title: StringsKeys.orders.tr),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: 60.h, child: CustStateOrders()),
                    ),
                    SliverSpacer(10.h),
                    GetBuilder(
                      init: OrdersControllreImp(),
                      builder: (controller) {
                        return Handlingdataviwe(
                          isSizedBox: true,
                          statusrequest: controller.statusrequest,
                          isSliver: true,
                          widget: SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            sliver: SliverList.builder(
                              itemCount: controller.data.length,
                              itemBuilder: (context, index) {
                                final order = controller.data[index];
                                return OrderCard(order: order);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:e_comerece/controller/local_service/view_orders_local_service_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/local_service/local_service_order_card.dart';
import 'package:e_comerece/viwe/widget/local_service/local_service_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewLocalServiceOrdersScreen extends StatelessWidget {
  const ViewLocalServiceOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewOrdersLocalServiceController());
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          PositionedAppBar(
            title: "طلبات الخدمات المحلية",
            onPressed: () => Get.back(),
          ),
          Column(
            children: [
              SizedBox(height: 100.h),
              const LocalServiceOrderState(),
              SizedBox(height: 10.h),
              Expanded(
                child: GetBuilder<ViewOrdersLocalServiceController>(
                  builder: (controller) {
                    return Handlingdataviwe(
                      statusrequest: controller.statusrequest,
                      isSizedBox: true,
                      widget: RefreshIndicator(
                        onRefresh: () async {
                          controller.refreshOrders();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          itemCount: controller.data.length,
                          itemBuilder: (context, index) {
                            return LocalServiceOrderCard(
                              order: controller.data[index],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

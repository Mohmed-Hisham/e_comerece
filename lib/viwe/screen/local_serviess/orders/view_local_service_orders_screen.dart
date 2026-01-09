import 'package:e_comerece/controller/local_service/view_orders_local_service_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/local_service/local_service_order_card.dart';
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
          const PositionedRight1(),
          const PositionedRight2(),
          PositionedAppBar(
            title: StringsKeys.localServiceOrdersTitle.tr,
            onPressed: () => Get.back(),
          ),
          Column(
            children: [
              SizedBox(height: 100.h),
              Expanded(
                child: GetBuilder<ViewOrdersLocalServiceController>(
                  builder: (controller) {
                    return Handlingdataviwe(
                      statusrequest: controller.statusrequest,
                      isSizedBox: true,
                      widget: RefreshIndicator(
                        color: Appcolor.primrycolor,
                        backgroundColor: Colors.transparent,
                        onRefresh: () async {
                          controller.refreshOrders();
                        },
                        child: ListView.builder(
                          controller: controller
                              .scrollController, // Added scroll controller
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            // vertical: 10.h,
                          ),
                          itemCount:
                              controller.data.length +
                              1, // +1 for loading indicator
                          itemBuilder: (context, index) {
                            if (index < controller.data.length) {
                              return LocalServiceOrderCard(
                                order: controller.data[index],
                              );
                            } else {
                              return controller.isLoadMore
                                  ? const ShimmerBar(
                                      height: 8,
                                      animationDuration: 1,
                                    )
                                  : const SizedBox();
                            }
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

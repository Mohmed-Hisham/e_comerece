import 'dart:developer';

import 'package:e_comerece/controller/local_service/local_service_order_details_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/address_card.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/note_card.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/order_details_header.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/order_summary_card.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/service_info_card.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/local_service/service_request_tracking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocalServiceOrderDetailsView extends StatelessWidget {
  const LocalServiceOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocalServiceOrderDetailsController());
    return Scaffold(
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          SafeArea(
            child: Column(
              children: [
                const OrderDetailsHeader(),
                Expanded(
                  child: GetBuilder<LocalServiceOrderDetailsController>(
                    builder: (controller) {
                      return Handlingdataviwe(
                        statusrequest: controller.statusrequest,
                        widget:
                            controller.statusrequest == Statusrequest.success &&
                                controller.requestDetails != null
                            ? _buildOrderDetails(controller)
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(LocalServiceOrderDetailsController controller) {
    final order = controller.requestDetails!;
    final service = order.service;
    final address = order.address;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServiceRequestTrackingWidget(currentStatus: order.status ?? 'new'),
          SizedBox(height: 20.h),

          OrderSummaryCard(
            requestId: order.requestId,
            createdAt: order.createdAt,
            status: order.status,
          ),
          SizedBox(height: 16.h),

          if (service != null) ...[
            ServiceInfoCard(service: service, quotedPrice: order.quotedPrice),
            SizedBox(height: 16.h),
          ],

          if (address != null) ...[
            AddressCard(address: address),
            SizedBox(height: 16.h),
          ],

          if (order.note != null && order.note!.isNotEmpty) ...[
            NoteCard(note: order.note!),
            SizedBox(height: 16.h),
          ],

          BuildChatButton(controller: controller),
        ],
      ),
    );
  }
}

class BuildChatButton extends StatelessWidget {
  final LocalServiceOrderDetailsController controller;
  const BuildChatButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.primrycolor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: () {
          controller.goToChat();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              StringsKeys.editServiceChat.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

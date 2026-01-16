import 'package:e_comerece/controller/orders/order_details_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/screen/orders/widget/delivery_address_card.dart';
import 'package:e_comerece/viwe/screen/orders/widget/general_order_summary_card.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_action_buttons.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_coupon_card.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_price_summary_card.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/ordres/order_detail_product_item.dart';
import 'package:e_comerece/viwe/widget/ordres/order_tracking_widget.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_input_field.dart';
import 'package:e_comerece/viwe/screen/Support/widget/chat_messages_list.dart';
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
import 'package:e_comerece/core/shared/widget_shared/chat_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsControllerImp());

    return Scaffold(
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          PositionedAppBar(
            title: StringsKeys.orderDetailsTitle.tr,
            onPressed: () => Get.back(),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 65.h),
                Expanded(
                  child: GetBuilder<OrderDetailsControllerImp>(
                    builder: (controller) {
                      return Handlingdataviwe(
                        statusrequest: controller.statusrequest,
                        widget: controller.orderData != null
                            ? Column(
                                children: [
                                  Expanded(
                                    child: _buildOrderDetails(controller),
                                  ),
                                  if (controller.orderData!.chatId != null)
                                    _buildChatSection(controller),
                                ],
                              )
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

  Widget _buildOrderDetails(OrderDetailsControllerImp controller) {
    final order = controller.orderData!;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Tracking Widget
          OrderTrackingWidget(
            currentStatus: order.status ?? 'pending_approval',
          ),
          SizedBox(height: 20.h),

          // Order Summary Card
          GeneralOrderSummaryCard(
            orderNumber: order.orderNumber,
            createdAt: order.createdAt != null
                ? DateTime.tryParse(order.createdAt!)
                : null,
            status: order.status,
            paymentMethod: order.paymentMethod,
          ),
          SizedBox(height: 16.h),

          // Address Card
          if (order.address != null) ...[
            DeliveryAddressCard(address: order.address!),
            SizedBox(height: 16.h),
          ],

          // Coupon Card (if exists)
          if (order.coupon != null) ...[
            OrderCouponCard(coupon: order.coupon!),
            SizedBox(height: 16.h),
          ],

          // Products Section
          if (order.items != null && order.items!.isNotEmpty) ...[
            _buildSectionTitle(StringsKeys.products.tr, Icons.shopping_bag),
            SizedBox(height: 12.h),
            ...order.items!.map((item) => OrderDetailProductItem(item: item)),
            SizedBox(height: 16.h),
          ],

          // Price Summary Card
          OrderPriceSummaryCard(
            subtotal: order.subtotal ?? 0,
            discountAmount: order.couponDiscount ?? 0,
            shippingAmount: order.deliveryTips ?? 0,
            totalAmount: order.total ?? 0,
          ),
          SizedBox(height: 20.h),

          // Action Buttons (Cancel & Reorder)
          const OrderActionButtons(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Appcolor.primrycolor, size: 24.sp),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Appcolor.black,
          ),
        ),
      ],
    );
  }

  Widget _buildChatSection(OrderDetailsControllerImp controller) {
    return Container(
      height: 350.h,
      decoration: BoxDecoration(
        color: Appcolor.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Appcolor.gray.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Icon(
                  Icons.chat_outlined,
                  color: Appcolor.primrycolor,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  StringsKeys.supportChatTitle.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.black,
                  ),
                ),
                const Spacer(),
                if (controller.isChatClosed)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.gray.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Chat Closed",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Appcolor.gray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: controller.messagesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ChatShimmer();
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error loading chat"));
                }

                final messages = snapshot.data ?? [];

                return Column(
                  children: [
                    Expanded(
                      child: ChatMessagesList(
                        messages: messages,
                        scrollController: controller.chatScrollController,
                      ),
                    ),
                    ChatInputField(
                      controller: controller as dynamic,
                      isInputDisabled: controller.isChatClosed,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

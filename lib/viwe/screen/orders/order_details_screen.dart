import 'package:e_comerece/controller/orders/order_details_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
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
          SafeArea(
            child: Column(
              children: [
                PositionedAppBar(
                  title: 'تفاصيل الطلب',
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: GetBuilder<OrderDetailsControllerImp>(
                    builder: (controller) {
                      return Handlingdataviwe(
                        statusrequest: controller.statusrequest,
                        widget: controller.orderData != null
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
            orderId: order.orderId,
            createdAt: order.createdAt,
            status: order.status,
            paymentMethod: order.paymentMethod,
            paymentStatus: order.paymentStatus,
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
          _buildSectionTitle('المنتجات', Icons.shopping_bag),
          SizedBox(height: 12.h),

          ...order.items.map((item) => OrderDetailProductItem(item: item)),

          SizedBox(height: 16.h),

          // Price Summary Card
          OrderPriceSummaryCard(
            subtotal: order.subtotal ?? 0,
            discountAmount: order.discountAmount?.toDouble() ?? 0,
            shippingAmount: order.shippingAmount?.toDouble() ?? 0,
            totalAmount: order.totalAmount ?? 0,
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
}

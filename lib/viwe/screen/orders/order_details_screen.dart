import 'package:e_comerece/controller/orders/order_details_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/ordres/order_detail_product_item.dart';
import 'package:e_comerece/viwe/widget/ordres/order_tracking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsControllerImp());

    return Scaffold(
      // backgroundColor: Appcolor.fourcolor,
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
          _buildSectionCard(
            title: 'معلومات الطلب',
            icon: Icons.receipt_long,
            children: [
              _buildInfoRow('رقم الطلب', '#${order.orderId ?? 'N/A'}'),
              _buildDivider(),
              _buildInfoRow(
                'تاريخ الطلب',
                order.createdAt != null
                    ? DateFormat('yyyy-MM-dd HH:mm').format(order.createdAt!)
                    : 'غير متوفر',
              ),
              _buildDivider(),
              _buildInfoRow(
                'حالة الطلب',
                _getStatusLabel(order.status),
                valueColor: _getStatusColor(order.status),
              ),
              _buildDivider(),
              _buildInfoRow(
                'طريقة الدفع',
                _getPaymentMethodLabel(order.paymentMethod),
              ),
              _buildDivider(),
              _buildInfoRow(
                'حالة الدفع',
                _getPaymentStatusLabel(order.paymentStatus),
                valueColor: order.paymentStatus == 'paid'
                    ? const Color(0xff4CAF50)
                    : Appcolor.threecolor,
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Address Card
          if (order.address != null) ...[
            _buildSectionCard(
              title: 'عنوان التوصيل',
              icon: Icons.location_on,
              children: [
                _buildInfoRow('العنوان', order.address!.title ?? 'غير متوفر'),
                _buildDivider(),
                _buildInfoRow('المدينة', order.address!.city ?? 'غير متوفر'),
                _buildDivider(),
                _buildInfoRow('الشارع', order.address!.street ?? 'غير متوفر'),
                _buildDivider(),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        'المبنى',
                        order.address!.buildingNumber ?? '-',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildInfoRow(
                        'الطابق',
                        order.address!.floor ?? '-',
                      ),
                    ),
                  ],
                ),
                _buildDivider(),
                _buildInfoRow('الشقة', order.address!.apartment ?? 'غير متوفر'),
                _buildDivider(),
                _buildInfoRow(
                  'رقم الهاتف',
                  order.address!.phone ?? 'غير متوفر',
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],

          // Coupon Card (if exists)
          if (order.coupon != null) ...[
            _buildSectionCard(
              title: 'كوبون الخصم',
              icon: Icons.local_offer,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Appcolor.primrycolor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Appcolor.primrycolor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Text(
                            order.coupon!.couponName ?? 'COUPON',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.primrycolor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '-\$${order.coupon!.couponDiscount ?? 0}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff4CAF50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],

          // Products Section
          _buildSectionTitle('المنتجات', Icons.shopping_bag),
          SizedBox(height: 12.h),

          ...order.items.map((item) => OrderDetailProductItem(item: item)),

          SizedBox(height: 16.h),

          // Price Summary Card
          _buildSectionCard(
            title: 'ملخص الطلب',
            icon: Icons.account_balance_wallet,
            children: [
              _buildPriceRow('المجموع الفرعي', order.subtotal ?? 0),
              _buildDivider(),
              _buildPriceRow(
                'الخصم',
                order.discountAmount?.toDouble() ?? 0,
                isDiscount: true,
              ),
              _buildDivider(),
              _buildPriceRow('الشحن', order.shippingAmount?.toDouble() ?? 0),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Appcolor.primrycolor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الإجمالي',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.black,
                      ),
                    ),
                    Text(
                      '\$${(order.totalAmount ?? 0).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.primrycolor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Action Buttons (Cancel & Reorder)
          GetBuilder<OrderDetailsControllerImp>(
            builder: (controller) {
              final canCancel = controller.canCancelOrder();
              final canReorder = controller.canReorder();

              if (!canCancel && !canReorder) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  if (canCancel && canReorder)
                    // Both buttons in a row
                    Row(
                      children: [
                        // Reorder Button
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: controller.isReordering
                                ? null
                                : () => controller.reorderItems(),
                            icon: controller.isReordering
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.refresh),
                            label: Text(
                              controller.isReordering
                                  ? 'جاري التحميل...'
                                  : 'إعادة الطلب',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.primrycolor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Cancel Button
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: controller.isCancelling
                                ? null
                                : () => controller.cancelOrder(),
                            icon: controller.isCancelling
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.cancel_outlined),
                            label: Text(
                              controller.isCancelling
                                  ? 'جاري الإلغاء...'
                                  : 'إلغاء الطلب',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.reed,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                      ],
                    )
                  else if (canCancel)
                    // Only Cancel Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.isCancelling
                            ? null
                            : () => controller.cancelOrder(),
                        icon: controller.isCancelling
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.cancel_outlined),
                        label: Text(
                          controller.isCancelling
                              ? 'جاري الإلغاء...'
                              : 'إلغاء الطلب',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.reed,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                      ),
                    )
                  else if (canReorder)
                    // Only Reorder Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.isReordering
                            ? null
                            : () => controller.reorderItems(),
                        icon: controller.isReordering
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.refresh),
                        label: Text(
                          controller.isReordering
                              ? 'جاري التحميل...'
                              : 'إعادة الطلب',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.primrycolor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appcolor.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Appcolor.primrycolor.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Appcolor.primrycolor, size: 24.sp),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.black,
                  ),
                ),
              ],
            ),
          ),

          // Section Content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
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

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Appcolor.gray),
          ),
          SizedBox(width: 12.w),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Appcolor.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Appcolor.gray),
          ),
          Text(
            '${isDiscount ? '-' : ''}\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDiscount ? const Color(0xff4CAF50) : Appcolor.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Divider(color: Appcolor.gray.withValues(alpha: 0.2), height: 1),
    );
  }

  String _getStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_approval':
        return 'قيد المراجعة';
      case 'approved':
        return 'تم الموافقة';
      case 'rejected':
        return 'مرفوض';
      case 'ordered':
        return 'تم الطلب';
      case 'completed':
        return 'مكتمل';
      case 'cancelled':
        return 'ملغي';
      default:
        return status ?? 'غير معروف';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_approval':
        return Appcolor.threecolor;
      case 'approved':
        return const Color(0xff4CAF50);
      case 'rejected':
        return Appcolor.reed;
      case 'ordered':
        return const Color(0xff2196F3);
      case 'completed':
        return const Color(0xff2E7D32);
      case 'cancelled':
        return Appcolor.gray;
      default:
        return Appcolor.primrycolor;
    }
  }

  String _getPaymentMethodLabel(String? method) {
    switch (method?.toLowerCase()) {
      case 'visa':
        return 'فيزا';
      case 'mastercard':
        return 'ماستر كارد';
      case 'cash':
        return 'كاش';
      default:
        return method ?? 'غير محدد';
    }
  }

  String _getPaymentStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'paid':
        return 'مدفوع';
      case 'pending':
        return 'في انتظار الدفع';
      case 'failed':
        return 'فشل';
      default:
        return status ?? 'غير محدد';
    }
  }
}

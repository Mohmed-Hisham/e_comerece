import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_section_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralOrderSummaryCard extends StatelessWidget {
  final int? orderId;
  final DateTime? createdAt;
  final String? status;
  final String? paymentMethod;
  final String? paymentStatus;

  const GeneralOrderSummaryCard({
    super.key,
    this.orderId,
    this.createdAt,
    this.status,
    this.paymentMethod,
    this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: 'معلومات الطلب',
      icon: Icons.receipt_long,
      children: [
        OrderInfoRow(label: 'رقم الطلب', value: '#${orderId ?? 'N/A'}'),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: 'تاريخ الطلب',
          value: createdAt != null
              ? DateFormat('yyyy-MM-dd HH:mm').format(createdAt!)
              : 'غير متوفر',
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: 'حالة الطلب',
          value: _getStatusLabel(status),
          valueColor: _getStatusColor(status),
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: 'طريقة الدفع',
          value: _getPaymentMethodLabel(paymentMethod),
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: 'حالة الدفع',
          value: _getPaymentStatusLabel(paymentStatus),
          valueColor: paymentStatus == 'paid'
              ? const Color(0xff4CAF50)
              : Appcolor.threecolor,
        ),
      ],
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

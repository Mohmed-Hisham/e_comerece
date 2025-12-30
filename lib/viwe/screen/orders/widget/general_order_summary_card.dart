import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_section_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      title: StringsKeys.orderInformation.tr,
      icon: Icons.receipt_long,
      children: [
        OrderInfoRow(
          label: StringsKeys.orderIdLabel.tr,
          value: '#${orderId ?? StringsKeys.notAvailable.tr}',
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: StringsKeys.orderDateLabel.tr,
          value: createdAt != null
              ? DateFormat('yyyy-MM-dd HH:mm').format(createdAt!)
              : StringsKeys.notAvailable.tr,
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: StringsKeys.orderStatusLabel.tr,
          value: _getStatusLabel(status),
          valueColor: _getStatusColor(status),
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: StringsKeys.paymentMethodLabel.tr,
          value: _getPaymentMethodLabel(paymentMethod),
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: StringsKeys.paymentStatusLabel.tr,
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
        return StringsKeys.orderStatusPendingApproval.tr;
      case 'approved':
        return StringsKeys.orderStatusApproved.tr;
      case 'rejected':
        return StringsKeys.orderStatusRejected.tr;
      case 'ordered':
        return StringsKeys.orderStatusOrdered.tr;
      case 'completed':
        return StringsKeys.orderStatusCompleted.tr;
      case 'cancelled':
        return StringsKeys.orderStatusCancelled.tr;
      default:
        return status ?? StringsKeys.unknownStatus.tr;
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
        return StringsKeys.visa.tr;
      case 'mastercard':
        return StringsKeys.mastercard.tr;
      case 'cash':
        return StringsKeys.cash.tr;
      default:
        return method ?? StringsKeys.notDefined.tr;
    }
  }

  String _getPaymentStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'paid':
        return StringsKeys.paid.tr;
      case 'pending':
        return StringsKeys.pendingPayment.tr;
      case 'failed':
        return StringsKeys.failedStatus.tr;
      default:
        return status ?? StringsKeys.notDefined.tr;
    }
  }
}

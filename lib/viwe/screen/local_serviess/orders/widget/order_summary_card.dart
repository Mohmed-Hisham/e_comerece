import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/section_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class OrderSummaryCard extends StatelessWidget {
  final String? requestId;
  final DateTime? createdAt;
  final String? status;

  const OrderSummaryCard({
    super.key,
    this.requestId,
    this.createdAt,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: StringsKeys.serviceInfoTitle.tr,
      icon: Icons.receipt_long,
      children: [
        InfoRow(
          label: StringsKeys.serviceNumber.tr,
          value: '#${requestId ?? 'N/A'}',
        ),
        const SectionDivider(),
        InfoRow(
          label: StringsKeys.serviceDate.tr,
          value: createdAt != null
              ? Jiffy.parse(
                  createdAt!.toIso8601String(),
                ).format(pattern: 'yyyy-MM-dd HH:mm')
              : StringsKeys.notAvailable.tr,
        ),
        const SectionDivider(),
        InfoRow(
          label: StringsKeys.serviceStatus.tr,
          value: _getStatusLabel(status),
          valueColor: _getStatusColor(status),
        ),
      ],
    );
  }

  String _getStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'new':
        return StringsKeys.statusNew.tr;
      case 'price_quoted':
        return StringsKeys.statusPriceQuoted.tr;
      case 'approved':
        return StringsKeys.statusApproved.tr;
      case 'rejected':
      case 'declined':
        return StringsKeys.statusRejected.tr;
      case 'completed':
        return StringsKeys.statusCompleted.tr;
      case 'cancelled':
        return StringsKeys.statusCancelled.tr;
      default:
        return status ?? StringsKeys.statusUnknown.tr;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'new':
        return Appcolor.threecolor;
      case 'price_quoted':
        return const Color(0xff2196F3);
      case 'approved':
        return const Color(0xff4CAF50);
      case 'rejected':
      case 'declined':
        return Appcolor.reed;
      case 'completed':
        return const Color(0xff2E7D32);
      case 'cancelled':
        return Appcolor.gray;
      default:
        return Appcolor.primrycolor;
    }
  }
}

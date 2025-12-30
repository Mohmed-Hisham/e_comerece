import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/section_card.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class OrderSummaryCard extends StatelessWidget {
  final int? requestId;
  final String? createdAt;
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
      title: 'معلومات الخدمة',
      icon: Icons.receipt_long,
      children: [
        InfoRow(label: 'رقم الخدمة', value: '#${requestId ?? 'N/A'}'),
        const SectionDivider(),
        InfoRow(
          label: 'تاريخ الخدمة',
          value: createdAt != null
              ? Jiffy.parse(createdAt!).format(pattern: 'yyyy-MM-dd HH:mm')
              : 'غير متوفر',
        ),
        const SectionDivider(),
        InfoRow(
          label: 'حالة الخدمة',
          value: _getStatusLabel(status),
          valueColor: _getStatusColor(status),
        ),
      ],
    );
  }

  String _getStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'new':
        return 'جديد';
      case 'price_quoted':
        return 'تم تحديد السعر';
      case 'approved':
        return 'تم الموافقة';
      case 'rejected':
      case 'declined':
        return 'مرفوض';
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

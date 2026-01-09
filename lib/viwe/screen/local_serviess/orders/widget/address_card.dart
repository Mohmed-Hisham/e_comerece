import 'package:e_comerece/data/model/local_service/service_request_details_model.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressCard extends StatelessWidget {
  final Address address;

  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'عنوان الخدمة',
      icon: Icons.location_on,
      children: [
        InfoRow(label: 'العنوان', value: address.title ?? 'غير متوفر'),
        const SectionDivider(),
        InfoRow(label: 'المدينة', value: address.city ?? 'غير متوفر'),
        const SectionDivider(),
        InfoRow(label: 'الشارع', value: address.street ?? 'غير متوفر'),
        const SectionDivider(),
        Row(
          children: [
            Expanded(
              child: InfoRow(
                label: 'المبنى',
                value: address.buildingNumber ?? '-',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: InfoRow(label: 'الطابق', value: address.floor ?? '-'),
            ),
          ],
        ),
        const SectionDivider(),
        InfoRow(label: 'الشقة', value: address.apartment ?? 'غير متوفر'),
      ],
    );
  }
}

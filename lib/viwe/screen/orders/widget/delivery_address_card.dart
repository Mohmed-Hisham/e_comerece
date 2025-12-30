import 'package:e_comerece/data/model/ordres/get_order_with_id_model.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryAddressCard extends StatelessWidget {
  final Address address;

  const DeliveryAddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: 'عنوان التوصيل',
      icon: Icons.location_on,
      children: [
        OrderInfoRow(label: 'العنوان', value: address.title ?? 'غير متوفر'),
        const OrderSectionDivider(),
        OrderInfoRow(label: 'المدينة', value: address.city ?? 'غير متوفر'),
        const OrderSectionDivider(),
        OrderInfoRow(label: 'الشارع', value: address.street ?? 'غير متوفر'),
        const OrderSectionDivider(),
        Row(
          children: [
            Expanded(
              child: OrderInfoRow(
                label: 'المبنى',
                value: address.buildingNumber ?? '-',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: OrderInfoRow(label: 'الطابق', value: address.floor ?? '-'),
            ),
          ],
        ),
        const OrderSectionDivider(),
        OrderInfoRow(label: 'الشقة', value: address.apartment ?? 'غير متوفر'),
        const OrderSectionDivider(),
        OrderInfoRow(label: 'رقم الهاتف', value: address.phone ?? 'غير متوفر'),
      ],
    );
  }
}

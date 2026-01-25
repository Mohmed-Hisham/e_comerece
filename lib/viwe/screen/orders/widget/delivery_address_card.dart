import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/model/ordres/order_details_model.dart';
import 'package:e_comerece/viwe/screen/orders/widget/order_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeliveryAddressCard extends StatelessWidget {
  final OrderAddress address;

  const DeliveryAddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: StringsKeys.deliveryAddress.tr,
      icon: Icons.location_on,
      children: [
        OrderInfoRow(
          label: StringsKeys.addressLabel.tr,
          value: address.title ?? StringsKeys.notAvailable.tr,
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: StringsKeys.city.tr,
          value: address.city ?? StringsKeys.notAvailable.tr,
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: StringsKeys.street.tr,
          value: address.street ?? StringsKeys.notAvailable.tr,
        ),
        const OrderSectionDivider(),
        Row(
          children: [
            Expanded(
              child: OrderInfoRow(
                label: StringsKeys.buildingNumber.tr,
                value: address.building ?? '-',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: OrderInfoRow(
                label: StringsKeys.floor.tr,
                value: address.floor ?? '-',
              ),
            ),
          ],
        ),
        const OrderSectionDivider(),
        OrderInfoRow(
          label: StringsKeys.apartment.tr,
          value: address.apartment ?? StringsKeys.notAvailable.tr,
        ),
      ],
    );
  }
}

import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddressCard extends StatelessWidget {
  final Address address;

  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: StringsKeys.serviceAddressTitle.tr,
      icon: Icons.location_on,
      children: [
        InfoRow(
          label: StringsKeys.addressLabel.tr,
          value: address.title ?? StringsKeys.notAvailable.tr,
        ),
        const SectionDivider(),
        InfoRow(
          label: StringsKeys.city.tr,
          value: address.city ?? StringsKeys.notAvailable.tr,
        ),
        const SectionDivider(),
        InfoRow(
          label: StringsKeys.street.tr,
          value: address.street ?? StringsKeys.notAvailable.tr,
        ),
        const SectionDivider(),
        Row(
          children: [
            Expanded(
              child: InfoRow(
                label: StringsKeys.serviceBuilding.tr,
                value: address.buildingNumber ?? '-',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: InfoRow(
                label: StringsKeys.serviceFloor.tr,
                value: address.floor ?? '-',
              ),
            ),
          ],
        ),
        const SectionDivider(),
        InfoRow(
          label: StringsKeys.serviceApartment.tr,
          value: address.apartment ?? StringsKeys.notAvailable.tr,
        ),
      ],
    );
  }
}

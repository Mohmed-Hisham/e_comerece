import 'package:e_comerece/controller/addresses/address_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/helper/bluer_dilog.dart';
import 'package:e_comerece/data/model/address/address_model.dart';
import 'package:e_comerece/viwe/screen/Address/edit_address.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/maps/shaimmer_botton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottonSheetLocation extends StatelessWidget {
  final double maxHeight;
  final bool showButtonBack;
  final BorderRadiusGeometry borderRadius;
  final ScrollPhysics physics;
  const BottonSheetLocation({
    super.key,
    this.maxHeight = 500,
    this.showButtonBack = true,
    this.physics = const BouncingScrollPhysics(),
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddressControllerImpl()..fetchAddresses(),
      builder: (controller) {
        return Handlingdataviwe(
          shimmer: LocationInfoShimmer(
            borderRadius: borderRadius,
            height: maxHeight,
          ),
          statusrequest: controller.fetchAddressesstatusrequest,
          widget: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.white,
            ),
            constraints: BoxConstraints(maxHeight: maxHeight.h),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringsKeys.deliveryAddress.tr,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.addAddess();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.plus,
                              color: Appcolor.primrycolor,
                            ),
                          ),
                          Text(
                            StringsKeys.addAddress.tr,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: physics,
                      itemCount: controller.addresses.length,
                      itemBuilder: (context, index) {
                        final address = controller.addresses[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: Appcolor.primrycolor),
                          ),
                          child: ListTile(
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: StringsKeys.deleteAddress.tr,
                                      middleText: StringsKeys
                                          .deleteAddressConfirmation
                                          .tr,
                                      textConfirm: StringsKeys.delete.tr,
                                      textCancel: StringsKeys.cancel.tr,
                                      onConfirm: () {
                                        controller.deleteAddress(
                                          addressId: address.addressId!,
                                        );
                                      },
                                    );
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.deleteLeft,
                                    color: Appcolor.primrycolor,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    blurDilog(
                                      EditAddress(index: index),
                                      context,
                                    );
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.penToSquare,
                                    color: Appcolor.primrycolor,
                                  ),
                                ),
                              ],
                            ),
                            dense: true,
                            leading: Radio(
                              value: address.isDefault,
                              groupValue: 1,
                              onChanged: (value) {
                                Datum addressupdate = Datum(
                                  addressId: address.addressId,
                                  isDefault: 1,
                                );

                                controller.updateAddress(addressupdate);
                              },
                              activeColor: Colors.orange,
                            ),
                            title: Text(address.addressTitle.toString()),
                            subtitle: Text(
                              "${address.city} -${address.street} -${address.buildingNumber} -${address.floor} -${address.apartment}",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (showButtonBack)
                    Custombuttonauth(
                      inputtext: StringsKeys.back.tr,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

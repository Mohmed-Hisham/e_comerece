import 'package:e_comerece/controller/addresses/address_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/data/model/address/address_model.dart';
import 'package:e_comerece/viwe/widget/maps/shaimmer_botton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckoutLocationCard extends StatelessWidget {
  const CheckoutLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: GetBuilder<AddressControllerImpl>(
        init: AddressControllerImpl()..fetchAddresses(),
        builder: (controller) {
          return HandlingdataviweNoEmty(
            shimmer: const LocationInfoShimmer(
              height: 200,
              borderRadius: BorderRadius.zero,
            ),
            statusrequest: controller.fetchAddressesstatusrequest,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringsKeys.deliveryAddress.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.black,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        controller.goToAddAddress();
                      },
                      icon: Icon(
                        Icons.add,
                        size: 16.sp,
                        color: Appcolor.primrycolor,
                      ),
                      label: Text(
                        StringsKeys.addAddress.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.primrycolor,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.addresses.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final address = controller.addresses[index];
                    final bool isSelected = address.isDefault == 1;

                    return GestureDetector(
                      onTap: () {
                        AddressData addressupdate = AddressData(
                          id: address.id,
                          isDefault: 1,
                        );
                        controller.updateAddress(addressupdate);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey[700],
                              size: 24.sp,
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address.title ?? StringsKeys.address.tr,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Appcolor.black,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    "${address.city} - ${address.street}, ${address.building}", // Simplified
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Radio<bool>(
                              value: true,
                              groupValue: isSelected ? true : null,
                              onChanged: (val) {
                                if (val == true) {
                                  AddressData addressupdate = AddressData(
                                    id: address.id,
                                    isDefault: 1,
                                  );
                                  controller.updateAddress(addressupdate);
                                }
                              },
                              activeColor: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

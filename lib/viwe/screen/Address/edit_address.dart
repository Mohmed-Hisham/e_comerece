import 'package:e_comerece/controller/addresses/address_controller.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/data/model/address/address_model.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditAddress extends StatelessWidget {
  final int index;

  const EditAddress({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return GetBuilder<AddressControllerImpl>(
      builder: (controller) {
        // textEditingControllers
        TextEditingController addressTitle = TextEditingController(
          text: controller.addresses[index].addressTitle.toString(),
        );
        TextEditingController city = TextEditingController(
          text: controller.addresses[index].city.toString(),
        );
        TextEditingController street = TextEditingController(
          text: controller.addresses[index].street.toString(),
        );
        TextEditingController buildingNumber = TextEditingController(
          text: controller.addresses[index].buildingNumber.toString(),
        );
        TextEditingController floor = TextEditingController(
          text: controller.addresses[index].floor.toString(),
        );
        TextEditingController apartment = TextEditingController(
          text: controller.addresses[index].apartment.toString(),
        );
        TextEditingController phone = TextEditingController(
          text: controller.addresses[index].phone.toString(),
        );
        return Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 10.h,
              children: [
                // SizedBox(height: 20.h),
                Custtextfeld(
                  hint: StringsKeys.addressTitle.tr,
                  controller: addressTitle,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: StringsKeys.city.tr,
                  controller: city,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: StringsKeys.street.tr,
                  controller: street,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(hint: StringsKeys.floor.tr, controller: floor),
                Custtextfeld(
                  hint: StringsKeys.buildingNumber.tr,
                  controller: buildingNumber,
                ),
                Custtextfeld(
                  hint: StringsKeys.apartment.tr,
                  controller: apartment,
                ),
                Custtextfeld(hint: StringsKeys.phone.tr, controller: phone),
                SizedBox(height: 20.h),

                Custombuttonauth(
                  inputtext: StringsKeys.save.tr,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Datum address = Datum(
                        addressId: controller.addresses[index].addressId,
                        addressTitle: addressTitle.text,
                        city: city.text,
                        street: street.text,
                        buildingNumber: buildingNumber.text,
                        floor: floor.text,
                        apartment: apartment.text,
                        phone: phone.text,
                      );
                      controller.updateAddress(address);
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

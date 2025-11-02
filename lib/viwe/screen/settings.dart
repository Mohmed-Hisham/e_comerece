import 'dart:developer';
import 'dart:math';

import 'package:e_comerece/controller/addresses/address_controller.dart';
import 'package:e_comerece/controller/settings_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/core/helper/bluer_dilog.dart';
import 'package:e_comerece/data/model/address/address_model.dart';
import 'package:e_comerece/routes.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:e_comerece/viwe/widget/maps/shaimmer_botton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsControllerImple controller = Get.put(SettingsControllerImple());
    return Container(
      child: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(height: Get.width / 2.5, color: Appcolor.primrycolor),
              Positioned(
                top: Get.width / 3.2,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(100),
                  child: Image.asset(
                    AppImagesassets.avata,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Disable Notfications"),
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  ListTile(
                    onTap: () {
                      Get.bottomSheet(BottonSheetLocation());
                    },
                    title: Text("Address"),
                    trailing: Icon(Icons.location_on_outlined),
                  ),

                  ListTile(
                    title: Text("About us"),
                    trailing: Icon(Icons.help_outline),
                  ),

                  ListTile(
                    title: Text("Conect us"),
                    trailing: Icon(Icons.contact_phone_outlined),
                  ),
                  ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    title: Text("Logout"),
                    trailing: Icon(Icons.logout),
                  ),
                  ListTile(
                    onTap: () {
                      controller.goToLanguagePage();
                    },
                    title: Text("language"),
                    trailing: Icon(Icons.language),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottonSheetLocation extends StatelessWidget {
  const BottonSheetLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddressControllerImpl()..fetchAddresses(),
      builder: (controller) {
        return Handlingdataviwe(
          shimmer: LocationInfoShimmer(),
          statusrequest: controller.fetchAddressesstatusrequest,
          widget: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              color: Colors.white,
            ),
            constraints: BoxConstraints(maxHeight: 500.h),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Address',
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
                            'Add Address',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
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
                                      title: "Delete Address",
                                      middleText:
                                          "Are you sure you want to delete this address?",
                                      textConfirm: "Delete",
                                      textCancel: "Cancel",
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
                              activeColor: Colors.orange, // اللون البرتقالي
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
                  Custombuttonauth(
                    inputtext: "back",
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
                  hint: "address title",
                  controller: addressTitle,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "city",
                  controller: city,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "street",
                  controller: street,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(hint: "floor", controller: floor),
                Custtextfeld(
                  hint: "building number",
                  controller: buildingNumber,
                ),
                Custtextfeld(hint: "apartment", controller: apartment),
                Custtextfeld(hint: "phone", controller: phone),
                SizedBox(height: 20.h),

                Custombuttonauth(
                  inputtext: "Save",
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

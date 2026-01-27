import 'package:e_comerece/controller/addresses/address_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:e_comerece/core/helper/bluer_dilog.dart';
import 'package:e_comerece/core/shared/widget_shared/animations.dart';
import 'package:e_comerece/data/model/address/address_model.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:e_comerece/viwe/widget/auth/custtextfeld.dart';
import 'package:e_comerece/viwe/widget/maps/shaimmer_botton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _CustGoogleMapState();
}

class _CustGoogleMapState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    Get.put(AddressControllerImpl());

    return Scaffold(
      body: GetBuilder<AddressControllerImpl>(
        builder: (getxcontroller) {
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                onTap: (position) {
                  getxcontroller.ubdataCameraPosition(
                    isontap: true,
                    latLngg: position,
                  );
                },
                markers: getxcontroller.newmarker,
                onMapCreated: (controller) {
                  getxcontroller.mapController = controller;
                  getxcontroller.ubdataCameraPosition();
                },

                initialCameraPosition: getxcontroller.initialCameraPosition,
              ),

              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Handlingdataviwe(
                  statusrequest: getxcontroller.mapstatusrequest,
                  shimmer: LocationInfoShimmer(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  widget: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 10,
                          blurRadius: 10,
                          offset: const Offset(10, 10),
                        ),
                      ],
                      color: Appcolor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    height: 250.h,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Spacer(flex: 1),
                        // SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'location info:',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: Appcolor.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      getxcontroller.ubdataCameraPosition();
                                    },
                                    icon: Icon(
                                      Icons.my_location,
                                      color: Appcolor.primrycolor,
                                      size: 40.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Country: ${getxcontroller.country}",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Appcolor.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                "City: ${getxcontroller.city}",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Appcolor.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                "street: ${getxcontroller.street}",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Appcolor.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Custombuttonauth(
                          inputtext: "continue".tr,
                          onPressed: () {
                            blurDilog(
                              Addlocattion(latLngg: getxcontroller.latLng),
                              context,
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
              GetBuilder<AddressControllerImpl>(
                id: "search",
                builder: (cont) {
                  return cont.isSearch
                      ? Positioned(
                          top: 0.h,
                          left: 0.w,
                          right: 0,
                          child: SlideUpFade(
                            visible: cont.initShow,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Appcolor.white2,
                                borderRadius: BorderRadius.circular(20.r),
                              ),

                              height: 950.h,
                              child: Column(
                                children: [
                                  SizedBox(height: 60.h),
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        final place = cont.predictions[index];
                                        return ListTile(
                                          trailing: const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Appcolor.primrycolor,
                                          ),
                                          leading: const Icon(
                                            Icons.fmd_good_sharp,
                                            color: Appcolor.primrycolor,
                                          ),
                                          title: Text(
                                            place.description.toString(),
                                          ),

                                          onTap: () async {
                                            cont.fetchPlaceDetails(
                                              place.placeId.toString(),
                                            );
                                            cont.closeSearch();
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Divider(),

                                      itemCount: cont.predictions.length,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
              Positioned(
                top: 50.h,
                right: 0,
                left: 0,
                child: Row(
                  children: [
                    PositionedAppBar(title: "", onPressed: Get.back),
                    SizedBox(
                      width: 350.w,
                      child: Custtextfeld(
                        controller: getxcontroller.searchController,
                        hint: "Search Place",
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            getxcontroller.search(val);
                          } else {
                            getxcontroller.closeSearch();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Addlocattion extends StatelessWidget {
  final LatLng latLngg;

  const Addlocattion({super.key, required this.latLngg});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return GetBuilder<AddressControllerImpl>(
      builder: (controller) {
        // textEditingControllers
        TextEditingController addressTitle = TextEditingController(
          text: '${controller.country}-${controller.city}-${controller.street}',
        );
        TextEditingController city = TextEditingController(
          text: controller.city,
        );
        TextEditingController street = TextEditingController(
          text: controller.street,
        );
        TextEditingController buildingNumber = TextEditingController();
        TextEditingController floor = TextEditingController();
        TextEditingController apartment = TextEditingController();
        TextEditingController phone = TextEditingController();
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
                    return validateInput(val: val!, min: 3, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "city",
                  controller: city,
                  validator: (val) {
                    return validateInput(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "street",
                  controller: street,
                  validator: (val) {
                    return validateInput(val: val!, min: 2, max: 100);
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
                      AddressData address = AddressData(
                        title: addressTitle.text,
                        city: city.text,
                        street: street.text,
                        building: buildingNumber.text,
                        floor: floor.text,
                        apartment: apartment.text,
                        phone: phone.text,
                        lat: latLngg.latitude,
                        lng: latLngg.longitude,
                        isDefault: 1,
                      );
                      controller.addAddress(address);
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

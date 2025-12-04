import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/location_servisess.dart';
import 'package:e_comerece/core/servises/map_places_serviese.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/addresses/add_addresses_data.dart';
import 'package:e_comerece/data/datasource/remote/addresses/get_addresses_data.dart';
import 'package:e_comerece/data/datasource/remote/addresses/remove_addresse_data.dart';
import 'package:e_comerece/data/datasource/remote/addresses/update_addresses_data.dart';
import 'package:e_comerece/data/model/address/address_model.dart';
import 'package:e_comerece/data/model/address/map_place_detalis_model.dart';
import 'package:e_comerece/data/model/address/map_places_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

abstract class AddressController extends GetxController {
  Future<void> fetchAddresses();
  Future<void> addAddress(Datum address);
  Future<void> updateAddress(Datum address);
  Future<void> deleteAddress({required int addressId});
}

class AddressControllerImpl extends AddressController {
  TextEditingController searchController = TextEditingController();
  MyServises myServises = Get.find();
  GetAddressesData getAddressesData = GetAddressesData(Get.find());
  AddAddressesData addAddressesData = AddAddressesData(Get.find());
  UpdateAddressesData updateAddressesData = UpdateAddressesData(Get.find());
  RemoveAddresseData removeAddresseData = RemoveAddresseData(Get.find());
  MapPlacesServiese mapPlacesServiese = MapPlacesServiese(Get.find());

  Statusrequest fetchAddressesstatusrequest = Statusrequest.loading;
  Statusrequest addAddressesstatusrequest = Statusrequest.none;
  Statusrequest updateAddressesstatusrequest = Statusrequest.none;
  Statusrequest deleteAddressesstatusrequest = Statusrequest.none;
  Statusrequest autoCompletestatusrequest = Statusrequest.none;
  Statusrequest placeDetailsstatusrequest = Statusrequest.none;
  Statusrequest mapstatusrequest = Statusrequest.loading;
  List<Datum> addresses = [];
  List<Prediction> predictions = [];
  Result? resultDetails;

  String? userId;
  bool isSearch = false;

  late LocationServisess locationServisess;
  late CameraPosition initialCameraPosition;
  late GoogleMapController mapController;
  late CameraPosition cameraPosition;
  String country = '';
  String city = '';
  String administrativeArea = '';
  String street = '';
  LatLng latLng = LatLng(0, 0);

  Set<Marker> newmarker = {};
  late Uuid uUid;
  String? sessionToken;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    userId = myServises.sharedPreferences.getString("user_id");
    locationServisess = LocationServisess();
    initialCameraPosition = CameraPosition(target: LatLng(0, 0));
    uUid = const Uuid();
  }

  void ubdataCameraPosition({bool isontap = false, LatLng? latLngg}) async {
    mapstatusrequest = Statusrequest.loading;
    update();
    LocationData locationData;

    if (isontap) {
      latLng = latLngg!;
    } else {
      locationData = await locationServisess.getlocation();
      latLng = LatLng(locationData.latitude!, locationData.longitude!);
    }
    try {
      Marker marker = Marker(
        markerId: const MarkerId("1"),
        position: latLng,
        infoWindow: const InfoWindow(title: "My Location"),
      );

      newmarker.add(marker);

      cameraPosition = CameraPosition(zoom: 12, target: latLng);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude,
          latLng.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          country = place.country ?? '';
          city = place.locality ?? place.subAdministrativeArea ?? '';
          administrativeArea = place.administrativeArea ?? '';
          administrativeArea = place.administrativeArea ?? '';
          street = place.street ?? '';
        }
      } catch (e) {
        log("error placemarks $e");
      }

      mapstatusrequest = Statusrequest.success;
      update();
    } on LocationServisessException catch (e) {
      showCustomGetSnack(isGreen: false, text: e.toString());
    } on LocationPermissionException catch (e) {
      showCustomGetSnack(isGreen: false, text: e.toString());
    }
  }

  @override
  fetchAddresses() async {
    userId = myServises.sharedPreferences.getString("user_id");
    log("userId $userId");
    try {
      if (userId == null) return;
      fetchAddressesstatusrequest = Statusrequest.loading;
      final response = await getAddressesData.getAddress(userId: userId!);

      fetchAddressesstatusrequest = handlingData(response);
      log("fetchAddressesstatusrequest $fetchAddressesstatusrequest");

      if (fetchAddressesstatusrequest == Statusrequest.success) {
        if (response['status'] == 'success' && response['data'].isNotEmpty) {
          addresses.clear();

          if (response['data'] is List) {
            addresses = (response['data'] as List)
                .map((e) => Datum.fromJson(e as Map<String, dynamic>))
                .toList();
            int myaddressId =
                myServises.sharedPreferences.getInt("default_address") ?? 0;
            if (myaddressId != addresses[0].addressId!) {
              myServises.sharedPreferences.setInt(
                "default_address",
                addresses[0].addressId!,
              );
            }
            log(
              "myaddressId ${myServises.sharedPreferences.getInt("default_address")}",
            );
          } else if (response['data'] is Map) {
            addresses = [
              Datum.fromJson(response['data'] as Map<String, dynamic>),
            ];
          }

          fetchAddressesstatusrequest = Statusrequest.success;
        }
        //  else {
        //   fetchAddressesstatusrequest = Statusrequest.failuer;
        // }
      }

      update();
    } catch (e) {
      fetchAddressesstatusrequest = Statusrequest.failuer;
      update();
    }
    log("fetchAddressesstatusrequest $fetchAddressesstatusrequest");
  }

  @override
  addAddress(Datum address) async {
    if (userId == null) return;

    try {
      addAddressesstatusrequest = Statusrequest.loading;

      final response = await addAddressesData.addAddress(
        data: address.toJson(),
      );

      addAddressesstatusrequest = handlingData(response);

      if (addAddressesstatusrequest == Statusrequest.success) {
        if (response['status'] == 'success' && response['data'] != null) {
          fetchAddresses();
          addAddressesstatusrequest = Statusrequest.success;
          Future.delayed(const Duration(seconds: 1), () {
            showCustomGetSnack(isGreen: true, text: "تم الاضافة بنجاح");
          });
        }
      } else {
        addAddressesstatusrequest = Statusrequest.failuer;
        Future.delayed(const Duration(seconds: 1), () {
          showCustomGetSnack(isGreen: false, text: "لم يتم الاضافة بنجاح");
        });
      }
    } catch (e) {
      print(e);
      addAddressesstatusrequest = Statusrequest.failuer;
      Future.delayed(const Duration(seconds: 1), () {
        showCustomGetSnack(isGreen: false, text: "لم يتم الاضافة بنجاح");
      });
    }
  }

  @override
  updateAddress(Datum address) async {
    if (userId == null) return;

    try {
      fetchAddressesstatusrequest = Statusrequest.loading;
      update();

      final response = await updateAddressesData.updateAddress(
        data: address.toJson(),
      );

      fetchAddressesstatusrequest = handlingData(response);

      if (fetchAddressesstatusrequest == Statusrequest.success) {
        if (response['status'] == 'success' && response['data'] != null) {
          Future.delayed(const Duration(seconds: 1), () {
            showCustomGetSnack(isGreen: true, text: "تم التعديل بنجاح");
          });
          fetchAddresses();
          fetchAddressesstatusrequest = Statusrequest.success;
        }
      } else {
        fetchAddressesstatusrequest = Statusrequest.failuer;
      }

      // update();
    } catch (e) {
      print(e);
      fetchAddressesstatusrequest = Statusrequest.failuer;
      update();
    }
  }

  @override
  deleteAddress({required int addressId}) async {
    if (userId == null) return;
    int defaultAddressId =
        myServises.sharedPreferences.getInt("default_address") ?? 0;
    if (addressId == defaultAddressId) {
      myServises.sharedPreferences.setInt(
        "default_address",
        addresses[0].addressId!,
      );
      updateAddress(Datum(isDefault: 1, addressId: addresses[0].addressId!));
    }

    try {
      updateAddressesstatusrequest = Statusrequest.loading;

      final response = await removeAddresseData.removeAddresse(
        addressId: addressId,
      );

      updateAddressesstatusrequest = handlingData(response);

      if (updateAddressesstatusrequest == Statusrequest.success) {
        if (response['status'] == 'success') {
          fetchAddresses();
          updateAddressesstatusrequest = Statusrequest.success;
        }
      } else {
        updateAddressesstatusrequest = Statusrequest.failuer;
      }

      // update();
    } catch (e) {
      print(e);
      updateAddressesstatusrequest = Statusrequest.failuer;
      update();
    }
  }

  @override
  void addAddess() {
    Get.toNamed(AppRoutesname.addAddresses);
  }

  placesAutocomplete(String text) async {
    autoCompletestatusrequest = Statusrequest.loading;
    sessionToken ??= Uuid().v4();

    log("sessionToken: $sessionToken");
    var response = await mapPlacesServiese.fetchPredictions(
      text,
      sessionToken!,
    );
    final status = handlingData(response);
    if (status == Statusrequest.success) {
      if (response['status'] == 'OK') {
        final places = MapPlacesModel.fromJson(response);
        predictions.clear();
        predictions = places.predictions;

        autoCompletestatusrequest = Statusrequest.success;
      } else {
        autoCompletestatusrequest = Statusrequest.failuer;
      }
    }
    update(['search']);
  }

  fetchPlaceDetails(String id) async {
    placeDetailsstatusrequest = Statusrequest.loading;
    var response = await mapPlacesServiese.getPlaceDetails(id);
    final status = handlingData(response);
    if (status == Statusrequest.success) {
      if (response['status'] == 'OK') {
        final details = MapPlacesDetailsModel.fromJson(response);
        resultDetails = details.result!;
        ubdataCameraPosition(
          isontap: true,
          latLngg: LatLng(
            resultDetails!.geometry!.location!.lat!,
            resultDetails!.geometry!.location!.lng!,
          ),
        );
        searchController.clear();
        sessionToken = null;

        placeDetailsstatusrequest = Statusrequest.success;
      } else {
        placeDetailsstatusrequest = Statusrequest.failuer;
      }
    }
  }

  search(String text) {
    if (text.length % 2 == 0 && text.isNotEmpty) {
      placesAutocomplete(text);
    }
    if (isSearch == false) {
      startInitShow();
      isSearch = true;
      update(['search']);
    }
  }

  closeSearch() {
    if (isSearch) {
      isSearch = false;
      initShow = false;
      update(['search']);
    }
  }

  bool initShow = false;

  startInitShow({int delayMs = 160}) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (!initShow) {
        initShow = true;
        update(['search']);
      }
    });
  }
}

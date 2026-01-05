import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/servises/location_servisess.dart';
import 'package:e_comerece/core/servises/map_places_serviese.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/model/address/address_model.dart';
import 'package:e_comerece/data/model/address/map_place_detalis_model.dart';
import 'package:e_comerece/data/model/address/map_places_model.dart';
import 'package:e_comerece/data/repository/Adresess/address_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

abstract class AddressController extends GetxController {
  Future<void> fetchAddresses();
  Future<void> addAddress(AddressData address);
  Future<void> updateAddress(AddressData address);
  Future<void> deleteAddress({required String addressId});
  void goToAddAddress();
}

class AddressControllerImpl extends AddressController {
  TextEditingController searchController = .new();
  MyServises myServises = Get.find();

  late AddressRepoImpl addressRepo;
  MapPlacesServiese mapPlacesServiese = MapPlacesServiese(Get.find());

  Statusrequest fetchAddressesstatusrequest = Statusrequest.loading;
  Statusrequest addAddressesstatusrequest = Statusrequest.none;
  Statusrequest updateAddressesstatusrequest = Statusrequest.none;
  Statusrequest deleteAddressesstatusrequest = Statusrequest.none;
  Statusrequest autoCompletestatusrequest = Statusrequest.none;
  Statusrequest placeDetailsstatusrequest = Statusrequest.none;
  Statusrequest mapstatusrequest = Statusrequest.loading;

  List<AddressData> addresses = [];
  List<Prediction> predictions = [];
  Result? resultDetails;

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
    addressRepo = AddressRepoImpl(apiServices: Get.find());
    locationServisess = LocationServisess();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
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
        infoWindow: InfoWindow(title: StringsKeys.myLocation.tr),
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
    fetchAddressesstatusrequest = Statusrequest.loading;
    update();

    var response = await addressRepo.getAddresses();

    fetchAddressesstatusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        addresses = r;
        if (addresses.isNotEmpty) {
          String? defaultAddressId = myServises.sharedPreferences.getString(
            "default_address",
          );

          // If no default address is set, or current default is not in the list, set the first one as default
          if (defaultAddressId == null && addresses.isNotEmpty) {
            myServises.sharedPreferences.setString(
              "default_address",
              addresses[0].id!,
            );
          }
        }
        return Statusrequest.success;
      },
    );

    if (addresses.isEmpty &&
        fetchAddressesstatusrequest == Statusrequest.success) {
      fetchAddressesstatusrequest = Statusrequest.noData;
    }

    update();
  }

  @override
  addAddress(AddressData address) async {
    addAddressesstatusrequest = Statusrequest.loading;
    update();

    var response = await addressRepo.addAddress(address);

    addAddressesstatusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        showCustomGetSnack(isGreen: true, text: r.message ?? "");
        fetchAddresses();
        return Statusrequest.success;
      },
    );
    update();
  }

  @override
  updateAddress(AddressData address) async {
    updateAddressesstatusrequest = Statusrequest.loading;
    update();

    var response = await addressRepo.updateAddress(address);

    updateAddressesstatusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        showCustomGetSnack(
          isGreen: true,
          text: r.message ?? StringsKeys.updateAddressSuccess.tr,
        );
        fetchAddresses();
        return Statusrequest.success;
      },
    );
    update();
  }

  @override
  deleteAddress({required String addressId}) async {
    deleteAddressesstatusrequest = Statusrequest.loading;
    update();

    var response = await addressRepo.deleteAddress(addressId);

    deleteAddressesstatusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        fetchAddresses();
        return Statusrequest.success;
      },
    );
    update();
  }

  @override
  void goToAddAddress() {
    Get.toNamed(AppRoutesname.addAddresses);
  }

  placesAutocomplete(String text) async {
    autoCompletestatusrequest = Statusrequest.loading;
    sessionToken ??= const Uuid().v4();

    log("sessionToken: $sessionToken");
    var response = await mapPlacesServiese.fetchPredictions(
      text,
      sessionToken!,
    );

    // Using simple logic for autocomplete status as it's not converted to repo yet
    if (response != null && response['status'] == 'OK') {
      final places = MapPlacesModel.fromJson(response);
      predictions.clear();
      predictions = places.predictions;
      autoCompletestatusrequest = Statusrequest.success;
    } else {
      autoCompletestatusrequest = Statusrequest.failuer;
    }

    update(['search']);
  }

  fetchPlaceDetails(String id) async {
    placeDetailsstatusrequest = Statusrequest.loading;
    var response = await mapPlacesServiese.getPlaceDetails(id);

    if (response != null && response['status'] == 'OK') {
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
    update();
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

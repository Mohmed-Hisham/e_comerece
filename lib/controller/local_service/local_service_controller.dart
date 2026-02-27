import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalServiceController extends GetxController {
  // GetLocalService getLocalService = GetLocalService(Get.find());
  LocalServiceRepoImpl localServiceRepoImpl = LocalServiceRepoImpl(
    apiService: Get.find(),
  );

  Statusrequest fetchstatusrequest = Statusrequest.none;
  Statusrequest searchstatusrequest = Statusrequest.none;
  List<LocalServiceData> services = [];
  List<LocalServiceData> searchservices = [];
  int page = 1;
  ScrollController scrollController = .new();
  TextEditingController searchController = .new();
  bool isSearch = false;
  bool isLoading = false;
  bool showClose = false;

  void checkSearch(String val) {
    if (val == "") {
      searchstatusrequest = Statusrequest.none;
      isSearch = false;
    }
    update();
  }

  void onSearchItems() {
    isSearch = true;
    searchLocalServices();
    update();
  }

  Future<void> searchLocalServices() async {
    searchstatusrequest = Statusrequest.loading;
    update();
    var response = await localServiceRepoImpl.searchLocalService(
      searchController.text,
    );
    searchstatusrequest = response.fold((l) => Statusrequest.failuer, (r) {
      searchservices = r.data;
      return Statusrequest.success;
    });

    if (searchservices.isEmpty &&
        searchstatusrequest == Statusrequest.success) {
      searchstatusrequest = Statusrequest.noData;
    }
    update();
  }

  @override
  void onInit() {
    fetchLocalService();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchLocalService(isLoadMore: true);
      }
    });
    super.onInit();
  }

  Future<void> fetchLocalService({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoading = true;
      update();
      page++;
    } else {
      fetchstatusrequest = Statusrequest.loading;
      update();
    }

    var response = await localServiceRepoImpl.getLocalService(
      page: page,
      pagesize: 6,
    );

    fetchstatusrequest = response.fold(
      (l) {
        if (isLoadMore) page--;
        return Statusrequest.failuer;
      },
      (r) {
        List<LocalServiceData> newServices = r.data;
        if (newServices.isEmpty) {
          if (isLoadMore) {
            page--;
            return Statusrequest.success;
          } else {
            return Statusrequest.noData;
          }
        } else {
          if (isLoadMore) {
            services.addAll(newServices);
          } else {
            services = newServices;
          }
          return Statusrequest.success;
        }
      },
    );

    isLoading = false;
    update();
  }

  void onCloseSearch() {
    if (isSearch) {
      isSearch = false;
      searchController.clear();
      update();
      showClose = false;
      // update(['initShow']);
    } else {
      searchController.clear();
      showClose = false;
      // update(['initShow']);
    }
  }

  void whenstartSearch(String q) {
    if (q != "") {
      showClose = true;
      update();
    } else {
      showClose = false;
    }
  }
}

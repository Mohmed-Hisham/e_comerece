import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/local_service/get_local_service_data.dart';
import 'package:e_comerece/data/datasource/remote/local_service/search_local_service_data.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalServiceController extends GetxController {
  GetLocalService getLocalService = GetLocalService(Get.find());
  SearchLocalService searchLocalService = SearchLocalService(Get.find());

  Statusrequest fetchstatusrequest = Statusrequest.none;
  Statusrequest searchstatusrequest = Statusrequest.none;
  List<Service> services = [];
  List<Service> searchservices = [];
  int page = 1;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  bool isLoading = false;

  checkSearch(val) {
    if (val == "") {
      searchstatusrequest = Statusrequest.none;
      isSearch = false;
    }
    update();
  }

  onSearchItems() {
    isSearch = true;
    searchLocalServices();
    update();
  }

  searchLocalServices() async {
    searchstatusrequest = Statusrequest.loading;
    var response = await searchLocalService.getSearchLocalService(
      search: searchController.text,
    );
    searchstatusrequest = handlingData(response);
    if (Statusrequest.success == searchstatusrequest) {
      if (response['status'] == 'success') {
        searchservices.clear();
        List data = response['data'];
        searchservices.addAll(data.map((e) => Service.fromJson(e)));
      } else {
        searchstatusrequest = Statusrequest.failuer;
      }
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

    var response = await getLocalService.gtelocalService(
      page: page,
      pagesize: 6,
    );
    var status = handlingData(response);

    if (Statusrequest.success == status) {
      if (response['status'] == 'success') {
        List data = response['data'];
        List<Service> newServices = data
            .map((e) => Service.fromJson(e))
            .toList();

        if (newServices.isEmpty) {
          if (isLoadMore) {
            page--;
          } else {
            fetchstatusrequest = Statusrequest.noData;
          }
        } else {
          if (isLoadMore) {
            services.addAll(newServices);
          } else {
            services = newServices;
            fetchstatusrequest = Statusrequest.success;
          }
        }
      } else {
        fetchstatusrequest = Statusrequest.failuer;
      }
    } else {
      fetchstatusrequest = status;
    }
    isLoading = false;
    update();
  }
}

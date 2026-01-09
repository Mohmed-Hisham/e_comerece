import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewOrdersLocalServiceController extends GetxController {
  final LocalServiceRepoImpl localServiceRepoImpl = LocalServiceRepoImpl(
    apiService: Get.find(),
  );
  Statusrequest statusrequest = Statusrequest.none;
  List<ServiceRequestData> data = [];

  // Pagination Variables
  int currentPage = 1;
  final int pageSize = 10;
  bool isLoadMore = false;
  bool hasMoreData = true;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getOrders();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadMore &&
          hasMoreData) {
        loadMore();
      }
    });
    super.onInit();
  }

  getOrders() async {
    currentPage = 1;
    data.clear();
    hasMoreData = true;
    statusrequest = Statusrequest.loading;
    update();

    final response = await localServiceRepoImpl.getRequestsByUser(
      page: currentPage,
      pageSize: pageSize,
    );

    response.fold(
      (failure) {
        statusrequest = Statusrequest.failuer;
      },
      (model) {
        data.addAll(model.data);
        if (model.data.length < pageSize) {
          hasMoreData = false;
        }
        if (data.isEmpty) {
          statusrequest = Statusrequest.noData;
        } else {
          statusrequest = Statusrequest.success;
        }
      },
    );
    update();
  }

  loadMore() async {
    isLoadMore = true;
    currentPage++;
    update();

    final response = await localServiceRepoImpl.getRequestsByUser(
      page: currentPage,
      pageSize: pageSize,
    );

    response.fold(
      (failure) {
        // Handle load more failure if needed, maybe show snackbar
        isLoadMore = false;
      },
      (model) {
        if (model.data.isNotEmpty) {
          data.addAll(model.data);
          if (model.data.length < pageSize) {
            hasMoreData = false;
          }
        } else {
          hasMoreData = false;
        }
        isLoadMore = false;
      },
    );
    update();
  }

  void refreshOrders() {
    getOrders();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

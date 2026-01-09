import 'dart:developer';

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo_impl.dart';
import 'package:get/get.dart';

class LocalServiceOrderDetailsController extends GetxController {
  final LocalServiceRepoImpl localServiceRepoImpl = LocalServiceRepoImpl(
    apiService: Get.find(),
  );

  ServiceRequestDetailData? requestDetails;
  Statusrequest statusrequest = Statusrequest.none;
  String? requestId;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments['service_request'] != null) {
      ServiceRequestData request = Get.arguments['service_request'];
      requestId = request.id;
      getData();
    }
    super.onInit();
  }

  getData({String? id}) async {
    if (id != null) {
      requestId = id;
    }
    if (requestId == null) return;
    statusrequest = Statusrequest.loading;
    update();
    log("id $requestId");

    final response = await localServiceRepoImpl.getServiceRequestDetails(
      requestId!,
    );

    response.fold(
      (failure) {
        statusrequest = Statusrequest.failuer;
        showCustomGetSnack(
          isGreen: false,
          text: failure.errorMessage,
          duration: const Duration(minutes: 5),
        );
      },
      (model) {
        requestDetails = model.data;
        statusrequest = Statusrequest.success;
      },
    );
    update();
  }

  goToChat() {
    if (requestDetails == null) return;
    Get.toNamed(
      AppRoutesname.messagesScreen,
      arguments: {
        'service_request_details': requestDetails,
        'chat_id': null,
        'platform': 'service_request',
      },
    );
  }
}

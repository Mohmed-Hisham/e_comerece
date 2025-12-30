import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/local_service/get_details_order_local_service_data.dart';
import 'package:e_comerece/data/datasource/remote/local_service/cancel_order_data.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:get/get.dart';

class LocalServiceOrderDetailsController extends GetxController {
  GetDetailsOrderLocalServiceData getDetailsOrderLocalServiceData =
      GetDetailsOrderLocalServiceData(Get.find());

  late ServiceRequestDetailData requestDetails;
  Statusrequest statusrequest = Statusrequest.none;
  CancelOrderData cancelOrderData = CancelOrderData(Get.find());
  int? requestId;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments['service_request'] != null) {
      ServiceRequestData request = Get.arguments['service_request'];
      requestId = request.requestId;
      getData();
    }
    super.onInit();
  }

  getData() async {
    if (requestId == null) return;
    statusrequest = Statusrequest.loading;
    update();
    var response = await getDetailsOrderLocalServiceData.getDetailsRequest(
      requestId: requestId!,
    );
    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        ServiceRequestDetailsModel model = ServiceRequestDetailsModel.fromJson(
          response,
        );
        if (model.data != null && model.data!.isNotEmpty) {
          requestDetails = model.data![0];
        } else {
          statusrequest = Statusrequest.failuer;
        }
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  goToChat() {
    Get.toNamed(
      AppRoutesname.messagesScreen,
      arguments: {
        'service_request_details': requestDetails,
        'chat_id':
            null, // Start new or find existing logic handled by controller
        'platform':
            'service_request', // Custom type to identify this flow if needed
      },
    );
  }
}

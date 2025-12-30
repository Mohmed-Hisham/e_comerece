import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/local_service/view_orders_data.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo.dart';
import 'package:get/get.dart';

class ViewOrdersLocalServiceController extends GetxController {
  LocalServiceRepo localServiceRepo = LocalServiceRepo(
    ViewOrdersData(Get.find()),
  );
  Statusrequest statusrequest = Statusrequest.none;
  MyServises myServises = Get.find();
  List<ServiceRequestData> data = [];

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  getOrders() async {
    data.clear();
    statusrequest = Statusrequest.loading;
    update();

    String? userid = myServises.sharedPreferences.getString("user_id");
    if (userid == null) {
      statusrequest = Statusrequest.failuer;
      update();
      return;
    }

    var response = await localServiceRepo.getOrders(userid);

    statusrequest = handlingData(response);

    if (Statusrequest.success == statusrequest) {
      response.fold(
        (l) {
          statusrequest = Statusrequest.failuer;
        },
        (r) {
          if (r['status'] == "success") {
            ServiceRequestModel model = ServiceRequestModel.fromJson(
              Map<String, dynamic>.from(r),
            );
            data.addAll(model.data!);
            if (data.isEmpty) {
              statusrequest = Statusrequest.noData;
            }
          } else {
            statusrequest = Statusrequest.failuer;
            if (r['status'] == "failure") {
              statusrequest = Statusrequest.noData;
            }
          }
        },
      );
    }
    update();
  }

  void refreshOrders() {
    getOrders();
  }
}

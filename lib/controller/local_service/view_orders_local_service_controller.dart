import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/datasource/remote/local_service/view_orders_data.dart';
import 'package:e_comerece/data/model/local_service/get_order_local_service_model.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo.dart';
import 'package:get/get.dart';

class ViewOrdersLocalServiceController extends GetxController {
  LocalServiceRepo localServiceRepo = LocalServiceRepo(
    ViewOrdersData(Get.find()),
  );
  Statusrequest statusrequest = Statusrequest.none;
  MyServises myServises = Get.find();
  List<Order> data = [];

  // Statuses: pending, accepted, completed, cancelled
  String currentStatus = "pending";

  @override
  void onInit() {
    getOrders(currentStatus);
    super.onInit();
  }

  void changeStatus(String status) {
    if (currentStatus == status) return;
    currentStatus = status;
    data.clear();
    getOrders(status);
    update();
  }

  getOrders(String status) async {
    data.clear();
    statusrequest = Statusrequest.loading;
    update();

    String? userid = myServises.sharedPreferences.getString("user_id");
    if (userid == null) {
      statusrequest = Statusrequest.failuer;
      update();
      return;
    }

    var response = await localServiceRepo.getOrders(userid, status);

    statusrequest = handlingData(response);

    if (Statusrequest.success == statusrequest) {
      response.fold(
        (l) {
          // Error handled in handlingData
        },
        (r) {
          if (r['status'] == "success") {
            // Check if data is null or empty list manually because GetOrderLocalServiceModel handles it but we parsing Map first?
            // Actually GetOrderLocalServiceModel.fromJson(r) will handle it.
            GetOrderLocalServiceModel model =
                GetOrderLocalServiceModel.fromJson(
                  Map<String, dynamic>.from(r),
                );
            data.addAll(model.data);
            if (data.isEmpty) {
              statusrequest = Statusrequest.noData;
            }
          } else {
            statusrequest = Statusrequest
                .failuer; // Or noData if status is failure but no error
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
    getOrders(currentStatus);
  }
}

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/test_data.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  TestData testData = TestData(Get.find());

  List data = [];
  late Statusrequest statusrequest;

  getDaat() async {
    statusrequest = Statusrequest.loading;
    var response = await testData.getData();
    statusrequest = handlingData(response);
    if (Statusrequest.success == statusrequest) {
      if (response['status'] == 'success') {
        data.addAll(response['data']);
      } else {
        statusrequest = Statusrequest.failuer;
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getDaat();
  }
}

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/shearshname_data.dart';
import 'package:e_comerece/data/model/categorymodel.dart';
import 'package:e_comerece/data/model/shearch_model.dart';
import 'package:get/get.dart';

abstract class ShearchnameController extends GetxController {
  fetchShearchname(String nameCat, int categoryId);
  changeCat(String valnaame, int valid);
}

class ShearchnameControllerImple extends ShearchnameController {
  final ShearshnameData shearshnameData = ShearshnameData(Get.find());
  Statusrequest statusrequest = Statusrequest.loading;
  ShearchNameModel? shearchNameModel;
  String? nameCat;
  int? categoryId;
  List<CategoryModel> categorymodel = [];

  @override
  void fetchShearchname(nameCat, categoryId) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await shearshnameData.getData(
      keyWord: nameCat,
      categoryId: categoryId,
    );
    statusrequest = handlingData(response);

    if (Statusrequest.success == statusrequest) {
      if (response['data'] != null) {
        shearchNameModel = ShearchNameModel.fromJson(response['data']);
      }
      statusrequest = Statusrequest.success;
    } else {
      statusrequest = Statusrequest.failuer;
    }
    update();
  }

  gotoditels(String id) {
    Get.toNamed(AppRoutesname.detelspage, arguments: {"product_id": id});
  }

  @override
  void onInit() {
    super.onInit();
    nameCat = Get.arguments["namecat"];
    categoryId = Get.arguments["categoryId"];
    categorymodel = Get.arguments["categorymodel"];
    fetchShearchname(nameCat!, categoryId!);
  }

  @override
  changeCat(valname, valid) {
    nameCat = valname;
    categoryId = valid;
    fetchShearchname(valname, valid);
    update();
  }
}

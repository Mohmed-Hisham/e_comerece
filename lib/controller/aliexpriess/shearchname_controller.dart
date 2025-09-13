import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/shearshname_data.dart';
import 'package:e_comerece/data/model/category_model.dart';
import 'package:e_comerece/data/model/shearch_model.dart';
import 'package:get/get.dart';

abstract class ShearchnameController extends GetxController {
  fetchShearchname(String nameCat, int categoryId);
  changeCat(String valnaame, int valid, int index);
}

class ShearchnameControllerImple extends ShearchnameController {
  final ShearshnameData shearshnameData = ShearshnameData(Get.find());
  Statusrequest statusrequest = Statusrequest.loading;
  SearchFromCatModel? searchFromCatModel;
  List<ResultList> items = [];
  String? nameCat;
  int? categoryId;
  List<ResultListCat> categorymodel = [];
  int selectedIndex = 0;

  @override
  void fetchShearchname(nameCat, categoryId) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await shearshnameData.getData(
      keyWord: nameCat,
      categoryId: categoryId,
    );
    print("response=>$response");
    statusrequest = handlingData(response);
    print("statusrequest=>$statusrequest");

    if (Statusrequest.success == statusrequest) {
      if (response is Map && response['result']?['status']?['code'] == 200) {
        final responseAsMap = response as Map<String, dynamic>;
        searchFromCatModel = SearchFromCatModel.fromJson(responseAsMap);
        List<ResultList> mainCategories =
            searchFromCatModel!.result!.resultList!;
        items.assignAll(mainCategories);
        statusrequest = Statusrequest.success;
      } else {
        statusrequest = Statusrequest.failuer;
      }
    } else {
      statusrequest = Statusrequest.failuer;
    }
    update();
  }

  gotoditels({required int id, required String lang}) {
    Get.toNamed(
      AppRoutesname.detelspage,
      arguments: {"product_id": id, "lang": lang},
    );
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
  changeCat(valname, valid, index) {
    nameCat = valname;
    categoryId = valid;
    selectedIndex = index;
    fetchShearchname(valname, valid);
    update();
  }
}

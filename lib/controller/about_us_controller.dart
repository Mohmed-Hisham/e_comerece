import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/about_us_model.dart';
import 'package:e_comerece/data/repository/about_us_repo.dart';
import 'package:get/get.dart';

abstract class AboutUsController extends GetxController {
  Future<void> getData();
}

class AboutUsControllerImpl extends AboutUsController {
  AboutUsRepoImpl aboutUsRepo = AboutUsRepoImpl(apiService: Get.find());
  Statusrequest statusrequest = Statusrequest.none;
  List<AboutUsData> aboutUsData = [];

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  Future<void> getData() async {
    statusrequest = Statusrequest.loading;
    update();

    final response = await aboutUsRepo.getAboutUs();

    statusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        aboutUsData = r.data;
        return Statusrequest.success;
      },
    );

    update();
  }
}

import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/legal_model.dart';
import 'package:e_comerece/data/repository/legal_repo.dart';
import 'package:get/get.dart';

abstract class LegalController extends GetxController {
  Future<void> getLegalData();
}

class LegalControllerImpl extends LegalController {
  final LegalRepoImpl legalRepo = LegalRepoImpl(apiService: Get.find());
  Statusrequest statusrequest = Statusrequest.none;
  List<LegalData> legalData = [];

  @override
  void onInit() {
    super.onInit();
    getLegalData();
  }

  @override
  Future<void> getLegalData() async {
    statusrequest = Statusrequest.loading;
    update();

    final response = await legalRepo.getLegalContent();

    statusrequest = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        legalData = r.data;
        return Statusrequest.success;
      },
    );

    update();
  }
}

import 'dart:async';
import 'package:e_comerece/core/funcations/checkinternet.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final RxBool isOnline = true.obs;
  Timer? _timer;
  bool _snackShown = false;

  @override
  void onInit() {
    super.onInit();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkAndUpdate(),
    );
  }

  Future<void> _checkAndUpdate() async {
    bool online = await checkInternet();
    if (online != isOnline.value) {
      isOnline.value = online;
    }
    _handleSnack(isOnline.value);
  }

  void _handleSnack(bool online) {
    if (!online) {
      if (!_snackShown) {
        _snackShown = true;
        showCustomGetSnack(
          isGreen: false,
          duration: const Duration(minutes: 10),
          text: StringsKeys.noInternetConnection.tr,
        );
      }
    } else {
      if (_snackShown) {
        if (Get.isSnackbarOpen) {
          Get.back();
        }
        _snackShown = false;
        showCustomGetSnack(
          isGreen: true,
          text: StringsKeys.internetConnectionRestored.tr,
        );
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

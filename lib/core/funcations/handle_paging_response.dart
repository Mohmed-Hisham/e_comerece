import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';

bool handle200(response) {
  if (response is Map<String, dynamic> &&
          response['result']?['status']['code'] == 200 ||
      response['result']?['status']['code'] == 201) {
    return true;
  } else {
    return false;
  }
}

bool handle205(response, int pageindex) {
  if (response is Map<String, dynamic> &&
      response['result']?['status']['code'] == 205 &&
      pageindex > 1) {
    return true;
  } else {
    return false;
  }
}

bool handle5008(response) {
  if (response is Map<String, dynamic> &&
          response['result']?['status']['code'] == 5008 ||
      response['result']?['status']['code'] == 5005) {
    return true;
  } else {
    return false;
  }
}

void custSnackBarNoMore() {
  showCustomGetSnack(isGreen: false, text: "no more data");
  // Get.snackbar("message", "no more data", snackPosition: SnackPosition.BOTTOM);
}

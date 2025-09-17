import 'package:e_comerece/core/class/statusrequest.dart';

Statusrequest handlingData(response) {
  if (response is Statusrequest) {
    return response;
  } else {
    return Statusrequest.success;
  }
}

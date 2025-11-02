import 'package:get/get_utils/src/get_utils/get_utils.dart';

vlidateInPut({
  required String val,
  required int min,
  required int max,
  String? type,
}) {
  if (val.isEmpty) {
    return "can't be Empty";
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "Not Valid Username";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "Not Valid Email";
    }
  }

  if (val.length < min) {
    return "can't be less then $min";
  }
  if (val.length > max) {
    return "can't be larger then $max";
  }
}

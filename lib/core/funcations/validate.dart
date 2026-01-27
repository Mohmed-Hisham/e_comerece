import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:get/get.dart';

enum ValidateType { username, email }

validateInput({
  required String val,
  required int min,
  required int max,
  ValidateType? type,
}) {
  if (val.isEmpty) {
    return StringsKeys.cantBeEmpty.tr;
  }
  if (type == ValidateType.username) {
    if (!GetUtils.isUsername(val)) {
      return StringsKeys.notValidUsername.tr;
    }
  }
  if (type == ValidateType.email) {
    if (!GetUtils.isEmail(val)) {
      return StringsKeys.notValidEmail.tr;
    }
  }

  if (val.length < min) {
    return "${StringsKeys.cantBeLessThan.tr} $min";
  }
  if (val.length > max) {
    return "${StringsKeys.cantBeLargerThan.tr} $max";
  }
}

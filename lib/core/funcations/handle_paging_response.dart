import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:get/get.dart';

void custSnackBarNoMore() {
  showCustomGetSnack(isGreen: false, text: StringsKeys.noMoreData.tr);
}

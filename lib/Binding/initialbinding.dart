import 'package:e_comerece/controller/aliexpriess/category_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:get/get.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.lazyPut(() => HomePageControllerImpl());
    Get.lazyPut(() => FavoritesController());
  }
}

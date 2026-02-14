import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/internet/connectivity_controller.dart';
import 'package:e_comerece/core/shared/widget_shared/likeanimationpage.dart';
import 'package:get/get.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoritesController(), permanent: true);
    Get.put(FavoriteAnimationController());
    Get.put(ConnectivityController(), permanent: true);
  }
}

import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/servises/supabase_service.dart';
import 'package:e_comerece/core/shared/widget_shared/likeanimationpage.dart';
import 'package:get/get.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.lazyPut(() => FavoritesController());
    Get.put(FavoriteAnimationController());
    Get.lazyPut(() => SupabaseService());
  }
}

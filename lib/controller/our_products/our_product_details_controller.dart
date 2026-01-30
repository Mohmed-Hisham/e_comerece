import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/data/repository/local_product/local_product_repo_impl.dart';
import 'package:get/get.dart';

class OurProductDetailsController extends GetxController {
  late LocalProductRepoImpl _localProductRepo;

  LocalProductModel? product;
  List<LocalProductModel> relatedProducts = [];
  Statusrequest relatedProductsStatus = Statusrequest.none;

  int _relatedPage = 1;
  final int _relatedPageSize = 10;
  bool hasMoreRelated = true;
  bool isLoadingMore = false;

  @override
  void onInit() {
    super.onInit();
    _localProductRepo = LocalProductRepoImpl(apiService: Get.find());

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['product'] != null) {
      product = args['product'] as LocalProductModel;
      fetchRelatedProducts();
    }
  }

  Future<void> fetchRelatedProducts() async {
    if (product?.id == null) return;

    relatedProductsStatus = Statusrequest.loading;
    update(['relatedProducts']);

    final result = await _localProductRepo.getProductById(
      productId: product!.id!,
      relatedPage: _relatedPage,
      relatedPageSize: _relatedPageSize,
    );

    result.fold(
      (failure) {
        relatedProductsStatus = Statusrequest.failuer;
      },
      (response) {
        if (response.relatedProducts?.products != null) {
          relatedProducts = response.relatedProducts!.products!;
          hasMoreRelated = response.relatedProducts!.hasMore;
        }
        relatedProductsStatus = Statusrequest.success;
      },
    );

    update(['relatedProducts']);
  }

  Future<void> loadMoreRelatedProducts() async {
    if (!hasMoreRelated || isLoadingMore || product?.id == null) return;

    isLoadingMore = true;
    _relatedPage++;
    update(['relatedProducts']);

    final result = await _localProductRepo.getProductById(
      productId: product!.id!,
      relatedPage: _relatedPage,
      relatedPageSize: _relatedPageSize,
    );

    result.fold(
      (failure) {
        _relatedPage--;
      },
      (response) {
        if (response.relatedProducts?.products != null) {
          relatedProducts.addAll(response.relatedProducts!.products!);
          hasMoreRelated = response.relatedProducts!.hasMore;
        }
      },
    );

    isLoadingMore = false;
    update(['relatedProducts']);
  }
}

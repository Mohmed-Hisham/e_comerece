import 'dart:developer';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/mixins/cart_info_mixin.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/data/repository/local_product/local_product_repo_impl.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/bottom_add_to_cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurProductDetailsController extends GetxController with CartInfoMixin {
  late LocalProductRepoImpl _localProductRepo;

  final ScrollController scrollController = ScrollController();

  LocalProductModel? product;
  String? productId;
  List<LocalProductModel> relatedProducts = [];
  Statusrequest relatedProductsStatus = Statusrequest.none;
  Statusrequest pageStatus = Statusrequest.none;
  @override
  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );

  int _relatedPage = 1;
  final int _relatedPageSize = 10;
  bool hasMoreRelated = true;
  bool isLoadingMore = false;
  String selectedAttributes = "";
  @override
  bool isFavorite = false;
  @override
  bool isInCart = false;
  @override
  int quantity = 1;
  @override
  int cartquantityDB = 0;
  @override
  bool isInfoLoading = true;

  @override
  CartButtonState cartButtonState = CartButtonState.addToCart;

  @override
  void onInit() {
    super.onInit();
    _localProductRepo = LocalProductRepoImpl(apiService: Get.find());

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args['product'] != null) {
        product = args['product'] as LocalProductModel;
        productId = product?.id;
        selectedAttributes = product?.description ?? "";
        pageStatus = Statusrequest.success;
      } else if (args['productid'] != null) {
        productId = args['productid'].toString();
        pageStatus = Statusrequest.loading;
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // Quantity methods
  void increment() {
    if (product?.stockQuantity == null || quantity < product!.stockQuantity!) {
      quantity++;
      _updateButtonState();
      update(['productInfo']);
    }
  }

  void decrement() {
    int minQty = 1;
    if (quantity > minQty) {
      quantity--;
      _updateButtonState();
      update(['productInfo']);
    }
  }

  void _updateButtonState() {
    if (isInCart && quantity != cartquantityDB) {
      cartButtonState = CartButtonState.updateInCart;
    } else if (isInCart && quantity == cartquantityDB) {
      cartButtonState = CartButtonState.added;
    } else {
      cartButtonState = CartButtonState.addToCart;
    }
  }

  // Add to cart method
  Future<void> onAddToCart(String attributes) async {
    if (product == null) return;
    cartButtonState = CartButtonState.loadingAddButton;
    update(['productInfo']);

    try {
      bool success = await addorrmoveController.add(
        productId.toString(),
        product!.title ?? '',
        product?.mainImage ?? "",
        product!.price?.toDouble() ?? 0.0,
        'localProduct',
        quantity,
        attributes,
        product!.stockQuantity ?? 0,
        tier: "",
        goodsSn: "",
        categoryId: product!.categoryId,
        porductink: '',
      );

      if (success) {
        cartquantityDB = quantity;
        isInCart = true;
        cartButtonState = CartButtonState.added;
        update(['productInfo']);
      }
    } catch (e, stackTrace) {
      log('onAddToCart error: $e ', stackTrace: stackTrace);
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchRelatedProducts();
    getCartItemInfo();
  }

  Future<void> fetchRelatedProducts() async {
    String? productId = product?.id;

    if (productId == null) {
      final args = Get.arguments as Map<String, dynamic>?;
      if (args != null && args['productid'] != null) {
        productId = args['productid'].toString();
      }
    }

    if (productId == null) return;

    if (product == null) {
      pageStatus = Statusrequest.loading;
      update();
    }

    relatedProductsStatus = Statusrequest.loading;
    update(['relatedProducts']);

    final result = await _localProductRepo.getProductById(
      productId: productId,
      relatedPage: _relatedPage,
      relatedPageSize: _relatedPageSize,
    );

    result.fold(
      (failure) {
        relatedProductsStatus = Statusrequest.failuer;
        if (product == null) {
          pageStatus = Statusrequest.failuer;
          update();
        }
      },
      (response) {
        if (product == null && response.product != null) {
          product = response.product;
          selectedAttributes = response.product?.description ?? "";
          pageStatus = Statusrequest.success;
          update();
        }

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
    // update(['relatedProducts']);

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

  @override
  String getProductId() => productId!.toString();

  @override
  String getSelectedAttributesJson() => selectedAttributes;
}

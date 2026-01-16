import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/funcations/handle_paging_response.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:e_comerece/data/repository/amazon/amazon_repo_impl.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/core/servises/custom_getx_snak_bar.dart';
import 'package:e_comerece/data/model/amazon_models/details_amazon_model.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:e_comerece/data/model/amazon_models/search_amazon_model.dart'
    as search;

abstract class ProductDetailsAmazonController extends GetxController {
  Future<void> fetchProductDetails();
  Future<void> initializeVideoPlayer();
  Future<void> getquiqtity(String attributes);
  void loadMoreSearch();
  Future<void> searshText();

  // Amazon Variation Management
  void initializeDefaultVariations();
  void updateSelectedVariation(String dimension, String value);
  void incrementQuantity();
  void decrementQuantity();
  void updateCurrentVariation();
  double? getCurrentPrice();
  String? getCurrentAsin();
  int getMinQuantity();
  void indexchange(int index);
  void resetStateForNewProduct();
  void gotoditels({required asin, required lang, required title});
}

class ProductDetailsAmazonControllerImple
    extends ProductDetailsAmazonController {
  AmazonRepoImpl amazonRepoImpl = AmazonRepoImpl(apiService: Get.find());
  AddorrmoveControllerimple addorrmoveController = Get.put(
    AddorrmoveControllerimple(),
  );

  Statusrequest statusrequest = Statusrequest.loading;
  DetailsAmazonModel? detailsAmazonModel;
  String? asin;
  String? lang;
  String? title;

  // Amazon variation management
  Map<String, String> selectedVariations = {};
  String? currentAsin;
  int quantity = 1;
  int cartquantityDB = 0;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  MyServises myServices = Get.find();
  Map<String, int> cartQuantities = {};

  List<CartModel> cartItems = [];
  List<String> productPhotos = [];
  List<String> productVariationsDimensions = [];
  Map<String, AllProductVariation> allProductVariations = {};
  ProductVariations? productVariations;

  int currentIndex = 0;
  String? imageAttribute;

  bool isLoading = false;
  // bool hasMoresearch = true;
  int pageIndexSearch = 0;
  Statusrequest statusrequestsearch = Statusrequest.none;
  List<search.Product> searchProducts = [];
  int loadSearchOne = 0;

  bool isInCart = false;
  bool isFavorite = false;

  // value for search
  bool hasMore = true;

  changisfavorite() {
    isFavorite = !isFavorite;
    // update();
  }

  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    asin = Get.arguments?["asin"];
    lang = Get.arguments?["lang"];
    title = Get.arguments?["title"];
    fetchProductDetails();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();

    super.onClose();
  }

  @override
  fetchProductDetails({String? asinParam}) async {
    statusrequest = Statusrequest.loading;
    update();

    final response = await amazonRepoImpl.fetchProductDetails(
      asinParam ?? asin!,
      lang!,
    );
    final r = response.fold((l) => l, (r) => r);

    if (r is Failure) {
      statusrequest = Statusrequest.failuer;
    }

    if (r is DetailsAmazonModel) {
      detailsAmazonModel = r;
      _buildUiSchemasFromModel();
      initializeDefaultVariations();
      statusrequest = Statusrequest.success;
      getquiqtity(jsonEncode(selectedVariations));
    }

    update(['selectedVariations']);
    update();

    final videoUrl = getVideoUrlString();
    if (videoUrl != null && videoUrl.isNotEmpty && videoUrl != "0") {
      await initializeVideoPlayer();
      update(['videoPlayerController']);
    }
  }

  @override
  searshText({bool isLoadMore = false, bool other = false}) async {
    if (isLoadMore) {
      if (isLoading || !hasMore) return;
      isLoading = true;
    } else {
      statusrequestsearch = Statusrequest.loading;
      pageIndexSearch = 1;
      searchProducts.clear();
      hasMore = true;
    }
    update(['product']);

    final response = await amazonRepoImpl.searchProducts(
      detectLangFromQueryAmazon(title!),
      title!,
      pageIndexSearch,
      "1",
      "2000",
    );

    statusrequestsearch = response.fold(
      (l) {
        showCustomGetSnack(isGreen: false, text: l.errorMessage);
        return Statusrequest.failuer;
      },
      (r) {
        final List<search.Product> iterable = r.data?.products ?? [];

        if (iterable.isEmpty && pageIndexSearch == 1) {
          hasMore = false;
          return Statusrequest.noData;
        } else if (iterable.isEmpty && pageIndexSearch > 1) {
          hasMore = false;
          custSnackBarNoMore();
          return Statusrequest.noDataPageindex;
        } else {
          searchProducts.addAll(iterable);
          pageIndexSearch++;
          return Statusrequest.success;
        }
      },
    );
  }

  @override
  loadMoreSearch() {
    searshText(isLoadMore: true);
  }

  @override
  initializeVideoPlayer() async {
    final raw = getVideoUrlString() ?? '';
    if (raw.isEmpty || raw == '0') return;

    final fixedUrl = raw.startsWith('//')
        ? 'https:$raw'
        : (raw.startsWith('http') ? raw : 'https://$raw');

    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(fixedUrl),
      );

      await videoPlayerController!.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        looping: true,
        showControls: true,
        errorBuilder: (context, error) => Center(child: Text('Error: $error')),
      );
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.code} - ${e.message} - ${e.details}');
    } catch (e, st) {
      debugPrint('Video init failed: $e\n$st');
    }
  }

  @override
  getquiqtity(attributes) async {
    try {
      // Convert ASIN to int for cart operations (assuming ASIN can be converted)
      // int productId = int.tryParse(asin!) ?? 0;

      final Map<String, dynamic> newQty = await addorrmoveController
          .cartquintty(asin!, attributes);
      log("newQty=>$newQty");
      isFavorite = newQty['in_favorite'];
      if (newQty['quantity'] != 0) {
        quantity = newQty['quantity'];
        cartquantityDB = newQty['quantity'];
        update(['quantity']);
        isInCart = true;
      } else {
        quantity = getMinQuantity();
        cartquantityDB = 0;
        isInCart = false;
        update(['quantity']);
      }
    } catch (e) {
      log("error=>$e");
    }
  }

  @override
  indexchange(index) {
    currentIndex = index;
    // carouselController.animateToPage(index);
    update(["videoPlayerController"]);
  }

  // Amazon-specific getter methods
  String? get productTitle => detailsAmazonModel?.data?.productTitle;
  String? get productPrice =>
      detailsAmazonModel?.data?.productPrice ??
      detailsAmazonModel?.data?.productOriginalPrice;
  String? get productOriginalPrice =>
      detailsAmazonModel?.data?.productOriginalPrice;
  String? get currencyFromApi => detailsAmazonModel?.data?.currency;
  String? get productByline => detailsAmazonModel?.data?.productByline;
  String? get productStarRating => detailsAmazonModel?.data?.productStarRating;
  int? get productNumRatings => detailsAmazonModel?.data?.productNumRatings;
  String? get productUrl => detailsAmazonModel?.data?.productUrl;
  String? get productPhoto => detailsAmazonModel?.data?.productPhoto;
  String? get productAvailability =>
      detailsAmazonModel?.data?.productAvailability;
  bool? get isBestSeller => detailsAmazonModel?.data?.isBestSeller;
  bool? get isAmazonChoice => detailsAmazonModel?.data?.isAmazonChoice;
  bool? get isPrime => detailsAmazonModel?.data?.isPrime;
  List<String> get aboutProduct => detailsAmazonModel?.data?.aboutProduct ?? [];
  String? get productDescription =>
      detailsAmazonModel?.data?.productDescription;
  String? get delivery => detailsAmazonModel?.data?.delivery;
  String? get primaryDeliveryTime =>
      detailsAmazonModel?.data?.primaryDeliveryTime;
  List<TopReview> get topReviews => detailsAmazonModel?.data?.topReviews ?? [];
  List<TopReview> get topReviewsGlobal =>
      detailsAmazonModel?.data?.topReviewsGlobal ?? [];
  List<FrequentlyBoughtTogether> get frequentlyBoughtTogether =>
      detailsAmazonModel?.data?.frequentlyBoughtTogether ?? [];
  String? get couponDiscountPercentage =>
      detailsAmazonModel?.data?.productOriginalPrice;
  bool? get hasVideo => detailsAmazonModel?.data?.hasVideo;
  List<ProductVideo> get productVideos =>
      detailsAmazonModel?.data?.productVideos ?? [];
  List<dynamic> get userUploadedVideos =>
      detailsAmazonModel?.data?.userUploadedVideos ?? [];

  // Build UI schemas from Amazon model data
  void _buildUiSchemasFromModel() {
    if (detailsAmazonModel?.data?.productPhotos != null) {
      productPhotos = detailsAmazonModel!.data!.productPhotos;
    }
    if (detailsAmazonModel?.data?.productVariationsDimensions != null) {
      productVariationsDimensions =
          detailsAmazonModel!.data!.productVariationsDimensions;
    }
    if (detailsAmazonModel?.data?.allProductVariations != null) {
      allProductVariations = detailsAmazonModel!.data!.allProductVariations;
    }
    if (detailsAmazonModel?.data?.productVariations != null) {
      productVariations = detailsAmazonModel!.data!.productVariations;
    }
  }

  @override
  void initializeDefaultVariations() {
    selectedVariations.clear();
    if (productVariationsDimensions.isNotEmpty) {
      // Initialize with first available option for each dimension
      for (var dimension in productVariationsDimensions) {
        if (dimension == 'color' &&
            productVariations?.color.isNotEmpty == true) {
          selectedVariations[dimension] = productVariations!.color.first.value!;
        } else if (dimension == 'size' &&
            productVariations?.size.isNotEmpty == true) {
          selectedVariations[dimension] = productVariations!.size.first.value!;
        }
      }
      updateCurrentVariation();
    }
    // Set default quantity to 1 for Amazon
    quantity = 1;
    update(['selectedVariations', 'quantity']);
  }

  @override
  void updateSelectedVariation(String dimension, String value) {
    selectedVariations[dimension] = value;
    updateCurrentVariation();
    getquiqtity(jsonEncode(selectedVariations));
    update(['selectedVariations', 'quantity']);
  }

  @override
  void updateCurrentVariation() {
    if (selectedVariations.isEmpty || allProductVariations.isEmpty) {
      currentAsin = asin; // Use original ASIN if no variations selected
      return;
    }

    // Find matching ASIN based on selected variations
    for (var entry in allProductVariations.entries) {
      bool matches = true;
      for (var selectedEntry in selectedVariations.entries) {
        if (selectedEntry.key == 'color' &&
            entry.value.color != selectedEntry.value) {
          matches = false;
          break;
        }
        if (selectedEntry.key == 'size' &&
            entry.value.size != selectedEntry.value) {
          matches = false;
          break;
        }
      }
      if (matches) {
        currentAsin = entry.key;
        break;
      }
    }
  }

  @override
  double? getCurrentPrice() {
    final priceString = productPrice;
    if (priceString == null || priceString.isEmpty) return null;

    String cleanPrice = priceString.replaceAll(RegExp(r'[^\d.,]'), '');

    if (cleanPrice.contains(',') && cleanPrice.contains('.')) {
      cleanPrice = cleanPrice.replaceAll(',', '');
    } else if (cleanPrice.contains(',') && !cleanPrice.contains('.')) {
      cleanPrice = cleanPrice.replaceAll(',', '.');
    }

    return double.tryParse(cleanPrice);
  }

  @override
  String? getCurrentAsin() {
    return asin;
  }

  @override
  int getMinQuantity() {
    // Amazon typically has minimum quantity of 1
    return 1;
  }

  @override
  void incrementQuantity({int? pressedCount}) {
    if (pressedCount == null) {
      quantity++;
      update(['quantity']);
    } else if (pressedCount >= getMinQuantity()) {
      quantity = pressedCount;
      update(['quantity']);
    }
  }

  @override
  void decrementQuantity() {
    int minQty = getMinQuantity();
    if (quantity > minQty) {
      quantity--;
      update(['quantity']);
    }
  }

  incart() {
    isInCart = true;
    update(['quantity']);
  }

  // Additional Amazon-specific utility methods
  String getCurrentPriceFormatted() {
    final cur = Get.find<CurrencyService>();
    return cur.convertAndFormat(
      amount: extractPrice(productPrice),
      from: 'SAR',
    );
  }

  String getOriginalPriceFormatted() {
    final cur = Get.find<CurrencyService>();
    return cur.convertAndFormat(
      amount: extractPrice(productOriginalPrice),
      from: 'SAR',
    );
  }

  double getRawUsdPrice() {
    final cur = Get.find<CurrencyService>();
    return cur.convert(
          amount: extractPrice(productPrice),
          from: 'SAR',
          to: 'USD',
        ) ??
        0.0;
  }

  String getCurrencyCode() {
    return Get.find<CurrencyService>().getCurrencySymbol(
      Get.find<CurrencyService>().selectedCurrency,
    );
  }

  // List<String> getAvailableColors() {
  //   return productVariations?.color.map((c) => c.value!).toList() ?? [];
  // }

  List<String> getAvailableSizes() {
    return productVariations?.size.map((s) => s.value!).toList() ?? [];
  }

  String getSelectedVariationDisplayName(String dimension) {
    return selectedVariations[dimension] ?? '';
  }

  bool isVariationSelected(String dimension, String value) {
    return selectedVariations[dimension] == value;
  }

  double getTotalPrice() {
    final currentPrice = extractPrice(productPrice);

    return currentPrice * quantity;
  }

  String getTotalPriceFormatted() {
    final totalPrice = getTotalPrice();
    final cur = Get.find<CurrencyService>();
    return cur.convertAndFormat(amount: totalPrice, from: 'SAR');
  }

  bool isProductAvailable() {
    return productAvailability?.toLowerCase().contains('in stock') ?? false;
  }

  String getProductRatingFormatted() {
    return productStarRating ?? '0.0';
  }

  String getProductRatingsCountFormatted() {
    return productNumRatings?.toString() ?? '0';
  }

  List<String> getProductImages() {
    return productPhotos.isNotEmpty ? productPhotos : [productPhoto ?? ''];
  }

  String? getVideoUrlString() {
    if (hasVideo == true && productVideos.isNotEmpty) {
      return productVideos.map((v) => v.videoUrl).first;
    }
    return null;
  }

  @override
  void resetStateForNewProduct() {
    try {
      if (chewieController != null) {
        chewieController!.pause();
        chewieController!.dispose();
        chewieController = null;
      }
    } catch (_) {}
    try {
      if (videoPlayerController != null) {
        videoPlayerController!.pause();
        videoPlayerController!.dispose();
        videoPlayerController = null;
      }
    } catch (_) {}

    detailsAmazonModel = null;
    selectedVariations.clear();
    currentAsin = null;
    quantity = 1;
    productPhotos.clear();
    productVariationsDimensions.clear();
    allProductVariations.clear();
    productVariations = null;
    imageAttribute = null;
    currentIndex = 0;

    statusrequest = Statusrequest.loading;
    isLoading = false;
    pageIndexSearch = 0;
    statusrequestsearch = Statusrequest.loading;
    searchProducts.clear();
    loadSearchOne = 0;

    cartQuantities.clear();

    update();
  }

  @override
  gotoditels({required asin, required lang, required title}) {
    Get.toNamed(
      AppRoutesname.productDetailsAmazonView,
      arguments: {"asin": asin, "lang": lang, "title": title},
      preventDuplicates: false,
    );
  }
}

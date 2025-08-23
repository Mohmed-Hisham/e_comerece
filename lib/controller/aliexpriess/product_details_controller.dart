import 'package:chewie/chewie.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/handlingdata.dart';
import 'package:e_comerece/data/datasource/remote/aliexpriess/product_details_data.dart';
import 'package:e_comerece/data/model/itemdetelis_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ProductDetailsController extends GetxController {
  final ProductDetailsData productDetailsData = ProductDetailsData(Get.find());
  Statusrequest statusrequest = Statusrequest.loading;
  ItemDetelis? itemDetails;
  String? productId;
  final PageController pageController = PageController(viewportFraction: 0.7);

  Map<String, String> selectedAttributes = {};
  SkuPriceList? currentSku;
  RxInt quantity = 1.obs;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['product_id'];
    fetchProductDetails();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  // ProductDetailsController

  void fetchProductDetails() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await productDetailsData.getData(productId!);
    statusrequest = handlingData(response); // <<-- استخدم handlingData هنا
    print(response);

    if (Statusrequest.success == statusrequest) {
      // >> هنا التصحيح <<
      // response الآن هو من نوع Map<String, dynamic>
      // تحقق من وجود مفتاح 'data' قبل استخدامه
      if (response['data'] != null) {
        itemDetails = ItemDetelis.fromJson(response['data']);
        _initializeDefaultAttributes();
        final videoUrl = itemDetails?.productInfoComponent?.video?.videoUrl;
        if (videoUrl != null && videoUrl.isNotEmpty && videoUrl != "0") {
          await _initializeVideoPlayer();
        }

        statusrequest = Statusrequest.success;
      } else {
        // الرد ناجح لكنه لا يحتوي على البيانات المتوقعة
        statusrequest = Statusrequest.failuer;
      }
    }

    update();
  }

  void _initializeDefaultAttributes() {
    if (itemDetails?.skuComponent?.productSKUPropertyList != null) {
      for (var attribute
          in itemDetails!.skuComponent!.productSKUPropertyList!) {
        if (attribute.skuPropertyValues != null &&
            attribute.skuPropertyValues!.isNotEmpty) {
          selectedAttributes[attribute.skuPropertyId!] = attribute
              .skuPropertyValues!
              .first
              .propertyValueId!
              .toString();
        }
      }
      _updateCurrentSku();
    }
  }

  void updateSelectedAttribute(String attributeId, String valueId) {
    selectedAttributes[attributeId] = valueId;
    _updateCurrentSku();
    update();
  }

  // ProductDetailsController

  void incrementQuantity() {
    if (currentSku != null &&
        quantity.value < currentSku!.skuVal!.availQuantity!) {
      quantity.value++;
    }
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void _updateCurrentSku() {
    if (itemDetails?.priceComponent?.skuPriceList == null) return;

    // >> هنا التصحيح <<
    currentSku = itemDetails!.priceComponent!.skuPriceList!.firstWhere(
      (sku) {
        // نحول السلسلتين إلى مجموعات (Set) لتجاهل الترتيب والعناصر المكررة
        final skuIds = sku.skuPropIds?.split(',').toSet();
        final selectedIdsSet = selectedAttributes.values.toSet();

        // نتحقق إذا كانت المجموعتان متساويتين
        return skuIds != null &&
            selectedIdsSet.length == skuIds.length &&
            selectedIdsSet.containsAll(skuIds);
      },
      // إذا لم نجد تطابقاً (قد يحدث عند بدء التحميل)، نرجع أول SKU كقيمة افتراضية
      orElse: () => itemDetails!.priceComponent!.skuPriceList!.first,
    );
  }

  Future<void> _initializeVideoPlayer() async {
    final videoUrl = itemDetails?.productInfoComponent?.video?.videoUrl;

    if (videoUrl != null && videoUrl.isNotEmpty && videoUrl != "0") {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );

      await videoPlayerController!.initialize(); // <<-- 2. أضف await هنا

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        looping: true, // changed from false for better UX
      );
    }
  }
}

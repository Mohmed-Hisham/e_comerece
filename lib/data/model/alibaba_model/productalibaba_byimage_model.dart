class ProductAliBabaByImageModel {
  ProductAliBabaByImageModel({required this.result});

  final Result? result;

  factory ProductAliBabaByImageModel.fromJson(Map<String, dynamic> json) {
    return ProductAliBabaByImageModel(
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }
}

class Result {
  Result({
    required this.status,
    required this.settings,
    required this.base,
    required this.resultList,
  });

  final Status? status;
  final Settings? settings;
  final Base? base;
  final List<ResultList> resultList;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      settings: json["settings"] == null
          ? null
          : Settings.fromJson(json["settings"]),
      base: json["base"] == null ? null : Base.fromJson(json["base"]),
      resultList: json["resultList"] == null
          ? []
          : List<ResultList>.from(
              json["resultList"]!.map((x) => ResultList.fromJson(x)),
            ),
    );
  }
}

class Base {
  Base({
    required this.imgRegion,
    required this.imgRegionFull,
    required this.pageSize,
    required this.totalResults,
    required this.categoryList,
  });

  final String? imgRegion;
  final String? imgRegionFull;
  final int? pageSize;
  final int? totalResults;
  final List<CategoryList> categoryList;

  factory Base.fromJson(Map<String, dynamic> json) {
    return Base(
      imgRegion: json["imgRegion"],
      imgRegionFull: json["imgRegionFull"],
      pageSize: json["pageSize"],
      totalResults: json["totalResults"],
      categoryList: json["categoryList"] == null
          ? []
          : List<CategoryList>.from(
              json["categoryList"]!.map((x) => CategoryList.fromJson(x)),
            ),
    );
  }
}

class CategoryList {
  CategoryList({required this.name, required this.id, required this.selected});

  final String? name;
  final String? id;
  final bool? selected;

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return CategoryList(
      name: json["name"],
      id: json["id"],
      selected: json["selected"],
    );
  }
}

class ResultList {
  ResultList({required this.item});

  final Item? item;

  factory ResultList.fromJson(Map<String, dynamic> json) {
    return ResultList(
      item: json["item"] == null ? null : Item.fromJson(json["item"]),
    );
  }
}

class Item {
  Item({
    required this.itemId,
    required this.title,
    required this.itemUrl,
    required this.image,
    required this.images,
    required this.sku,
    required this.averageStarRate,
  });

  final String? itemId;
  final String? title;
  final String? itemUrl;
  final String? image;
  final List<String> images;
  final Sku? sku;
  final String? averageStarRate;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json["itemId"],
      title: json["title"],
      itemUrl: json["itemUrl"],
      image: json["image"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      sku: json["sku"] == null ? null : Sku.fromJson(json["sku"]),
      averageStarRate: json["averageStarRate"],
    );
  }
}

class Sku {
  Sku({required this.def});

  final Def? def;

  factory Sku.fromJson(Map<String, dynamic> json) {
    return Sku(def: json["def"] == null ? null : Def.fromJson(json["def"]));
  }
}

class Def {
  Def({required this.priceModule, required this.quantityModule});

  final PriceModule? priceModule;
  final QuantityModule? quantityModule;

  factory Def.fromJson(Map<String, dynamic> json) {
    return Def(
      priceModule: json["priceModule"] == null
          ? null
          : PriceModule.fromJson(json["priceModule"]),
      quantityModule: json["quantityModule"] == null
          ? null
          : QuantityModule.fromJson(json["quantityModule"]),
    );
  }
}

class PriceModule {
  PriceModule({required this.priceFormatted});

  final String? priceFormatted;

  factory PriceModule.fromJson(Map<String, dynamic> json) {
    return PriceModule(priceFormatted: json["priceFormatted"]);
  }
}

class QuantityModule {
  QuantityModule({required this.minOrder});

  final MinOrder? minOrder;

  factory QuantityModule.fromJson(Map<String, dynamic> json) {
    return QuantityModule(
      minOrder: json["minOrder"] == null
          ? null
          : MinOrder.fromJson(json["minOrder"]),
    );
  }
}

class MinOrder {
  MinOrder({required this.quantity, required this.quantityFormatted});

  final String? quantity;
  final String? quantityFormatted;

  factory MinOrder.fromJson(Map<String, dynamic> json) {
    return MinOrder(
      quantity: json["quantity"],
      quantityFormatted: json["quantityFormatted"],
    );
  }
}

class Settings {
  Settings({
    required this.page,
    required this.catId,
    required this.imgRegion,
    required this.imgUrl,
    required this.region,
    required this.locale,
    required this.currency,
  });

  final String? page;
  final String? catId;
  final String? imgRegion;
  final String? imgUrl;
  final String? region;
  final String? locale;
  final String? currency;

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      page: json["page"],
      catId: json["catId"],
      imgRegion: json["imgRegion"],
      imgUrl: json["imgUrl"],
      region: json["region"],
      locale: json["locale"],
      currency: json["currency"],
    );
  }
}

class Status {
  Status({
    required this.code,
    required this.debug,
    required this.data,
    required this.executionTime,
    required this.requestTime,
    required this.requestId,
    required this.endpoint,
    required this.apiVersion,
    required this.functionsVersion,
    required this.la,
    required this.pmu,
    required this.mu,
  });

  final int? code;
  final Debug? debug;
  final String? data;
  final String? executionTime;
  final DateTime? requestTime;
  final String? requestId;
  final String? endpoint;
  final String? apiVersion;
  final String? functionsVersion;
  final String? la;
  final int? pmu;
  final int? mu;

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json["code"],
      debug: json["debug"] == null ? null : Debug.fromJson(json["debug"]),
      data: json["data"],
      executionTime: json["executionTime"],
      requestTime: DateTime.tryParse(json["requestTime"] ?? ""),
      requestId: json["requestId"],
      endpoint: json["endpoint"],
      apiVersion: json["apiVersion"],
      functionsVersion: json["functionsVersion"],
      la: json["la"],
      pmu: json["pmu"],
      mu: json["mu"],
    );
  }
}

class Debug {
  Debug({required this.imageProcessing, required this.apiProcessing});

  final ImageProcessing? imageProcessing;
  final ApiProcessing? apiProcessing;

  factory Debug.fromJson(Map<String, dynamic> json) {
    return Debug(
      imageProcessing: json["image_processing"] == null
          ? null
          : ImageProcessing.fromJson(json["image_processing"]),
      apiProcessing: json["api_processing"] == null
          ? null
          : ApiProcessing.fromJson(json["api_processing"]),
    );
  }
}

class ApiProcessing {
  ApiProcessing({required this.attempt});

  final int? attempt;

  factory ApiProcessing.fromJson(Map<String, dynamic> json) {
    return ApiProcessing(attempt: json["attempt"]);
  }
}

class ImageProcessing {
  ImageProcessing({required this.downloadTime, required this.uploadTime});

  final String? downloadTime;
  final String? uploadTime;

  factory ImageProcessing.fromJson(Map<String, dynamic> json) {
    return ImageProcessing(
      downloadTime: json["download-time"],
      uploadTime: json["upload-time"],
    );
  }
}

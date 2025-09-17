class SearchByImageModel {
  SearchByImageModel({required this.result});

  final Result? result;

  factory SearchByImageModel.fromJson(Map<String, dynamic> json) {
    return SearchByImageModel(
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
    required this.sortValues,
    required this.imgRegion,
    required this.imgRegionFull,
    required this.categoryList,
  });

  final List<String> sortValues;
  final String? imgRegion;
  final String? imgRegionFull;
  final List<CategoryList> categoryList;

  factory Base.fromJson(Map<String, dynamic> json) {
    return Base(
      sortValues: json["sortValues"] == null
          ? []
          : List<String>.from(json["sortValues"]!.map((x) => x)),
      imgRegion: json["imgRegion"],
      imgRegionFull: json["imgRegionFull"],
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
    required this.sales,
    required this.itemUrl,
    required this.image,
    required this.sku,
    required this.averageStarRate,
  });

  final String? itemId;
  final String? title;
  final int? sales;
  final String? itemUrl;
  final String? image;
  final Sku? sku;
  final double? averageStarRate;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json["itemId"],
      title: json["title"],
      sales: json["sales"],
      itemUrl: json["itemUrl"],
      image: json["image"],
      sku: json["sku"] == null ? null : Sku.fromJson(json["sku"]),
      averageStarRate: json["averageStarRate"] is num
          ? json["averageStarRate"].toDouble()
          : null,
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
  Def({required this.price, required this.promotionPrice});

  final dynamic price;
  final double? promotionPrice;

  factory Def.fromJson(Map<String, dynamic> json) {
    return Def(
      price: json["price"],
      promotionPrice: json["promotionPrice"] is num
          ? json["promotionPrice"].toDouble()
          : null,
    );
  }
}

class Settings {
  Settings({
    required this.catId,
    required this.sort,
    required this.imgRegion,
    required this.imgUrl,
    required this.region,
    required this.locale,
    required this.currency,
  });

  final String? catId;
  final String? sort;
  final String? imgRegion;
  final String? imgUrl;
  final String? region;
  final String? locale;
  final String? currency;

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      catId: json["catId"],
      sort: json["sort"],
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
  ApiProcessing({required this.attempt, required this.executionTime});

  final int? attempt;
  final String? executionTime;

  factory ApiProcessing.fromJson(Map<String, dynamic> json) {
    return ApiProcessing(
      attempt: json["attempt"],
      executionTime: json["executionTime"],
    );
  }
}

class ImageProcessing {
  ImageProcessing({required this.executionTime});

  final String? executionTime;

  factory ImageProcessing.fromJson(Map<String, dynamic> json) {
    return ImageProcessing(executionTime: json["executionTime"]);
  }
}

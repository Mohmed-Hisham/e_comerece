class ProductAliBabaHomeModel {
  ProductAliBabaHomeModel({required this.result});

  final Result? result;

  factory ProductAliBabaHomeModel.fromJson(Map<String, dynamic> json) {
    return ProductAliBabaHomeModel(
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

  final ResultStatus? status;
  final Settings? settings;
  final Base? base;
  final List<ResultList> resultList;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      status: json["status"] == null
          ? null
          : ResultStatus.fromJson(json["status"]),
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
  Base({required this.totalResults});

  final int? totalResults;

  factory Base.fromJson(Map<String, dynamic> json) {
    return Base(totalResults: json["totalResults"]);
  }
}

class ResultList {
  ResultList({required this.item, required this.seller, required this.company});

  final Item? item;
  final Seller? seller;
  final Company? company;

  factory ResultList.fromJson(Map<String, dynamic> json) {
    return ResultList(
      item: json["item"] == null ? null : Item.fromJson(json["item"]),
      seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      company: json["company"] == null
          ? null
          : Company.fromJson(json["company"]),
    );
  }
}

class Company {
  Company({
    required this.companyName,
    required this.companyId,
    required this.status,
    required this.companyBuildingSize,
    required this.companyEmployeesCount,
    required this.companyAddress,
  });

  final String? companyName;
  final int? companyId;
  final CompanyStatus? status;
  final String? companyBuildingSize;
  final String? companyEmployeesCount;
  final CompanyAddress? companyAddress;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json["companyName"],
      companyId: json["companyId"],
      status: json["status"] == null
          ? null
          : CompanyStatus.fromJson(json["status"]),
      companyBuildingSize: json["companyBuildingSize"],
      companyEmployeesCount: json["companyEmployeesCount"],
      companyAddress: json["companyAddress"] == null
          ? null
          : CompanyAddress.fromJson(json["companyAddress"]),
    );
  }
}

class CompanyAddress {
  CompanyAddress({required this.country, required this.countryCode});

  final String? country;
  final String? countryCode;

  factory CompanyAddress.fromJson(Map<String, dynamic> json) {
    return CompanyAddress(
      country: json["country"],
      countryCode: json["countryCode"],
    );
  }
}

class CompanyStatus {
  CompanyStatus({
    required this.assessed,
    required this.gold,
    required this.verified,
    required this.tradeAssurance,
  });

  final bool? assessed;
  final bool? gold;
  final bool? verified;
  final String? tradeAssurance;

  factory CompanyStatus.fromJson(Map<String, dynamic> json) {
    return CompanyStatus(
      assessed: json["assessed"],
      gold: json["gold"],
      verified: json["verified"],
      tradeAssurance: json["tradeAssurance"],
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
  });

  final String? itemId;
  final String? title;
  final String? itemUrl;
  final String? image;
  final List<String> images;
  final Sku? sku;

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
  PriceModule({
    required this.price,
    required this.priceFormatted,
    required this.priceList,
  });

  final String? price;
  final String? priceFormatted;
  final List<PriceList> priceList;

  factory PriceModule.fromJson(Map<String, dynamic> json) {
    return PriceModule(
      price: json["price"],
      priceFormatted: json["priceFormatted"],
      priceList: json["priceList"] == null
          ? []
          : List<PriceList>.from(
              json["priceList"]!.map((x) => PriceList.fromJson(x)),
            ),
    );
  }
}

class PriceList {
  PriceList({
    required this.price,
    required this.priceFormatted,
    required this.minQuantity,
    required this.maxQuantity,
    required this.unit,
  });

  final String? price;
  final String? priceFormatted;
  final int? minQuantity;
  final int? maxQuantity;
  final String? unit;

  factory PriceList.fromJson(Map<String, dynamic> json) {
    return PriceList(
      price: json["price"],
      priceFormatted: json["priceFormatted"],
      minQuantity: json["minQuantity"],
      maxQuantity: json["maxQuantity"],
      unit: json["unit"],
    );
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
  MinOrder({
    required this.quantity,
    required this.unit,
    required this.quantityFormatted,
  });

  final String? quantity;
  final String? unit;
  final String? quantityFormatted;

  factory MinOrder.fromJson(Map<String, dynamic> json) {
    return MinOrder(
      quantity: json["quantity"],
      unit: json["unit"],
      quantityFormatted: json["quantityFormatted"],
    );
  }
}

class Seller {
  Seller({
    required this.storeUrl,
    required this.storeImage,
    required this.storeAge,
    required this.storeEvaluates,
  });

  final String? storeUrl;
  final String? storeImage;
  final String? storeAge;
  final dynamic storeEvaluates;

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      storeUrl: json["storeUrl"],
      storeImage: json["storeImage"],
      storeAge: json["storeAge"],
      storeEvaluates: json["storeEvaluates"],
    );
  }
}

class Settings {
  Settings({
    required this.q,
    required this.catId,
    required this.loc,
    required this.attr,
    required this.switches,
    required this.sort,
    required this.page,
    required this.startPrice,
    required this.endPrice,
    required this.quantity,
    required this.region,
    required this.locale,
    required this.currency,
  });

  final String? q;
  final String? catId;
  final String? loc;
  final String? attr;
  final String? switches;
  final String? sort;
  final String? page;
  final String? startPrice;
  final String? endPrice;
  final String? quantity;
  final String? region;
  final String? locale;
  final String? currency;

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      q: json["q"],
      catId: json["catId"],
      loc: json["loc"],
      attr: json["attr"],
      switches: json["switches"],
      sort: json["sort"],
      page: json["page"],
      startPrice: json["startPrice"],
      endPrice: json["endPrice"],
      quantity: json["quantity"],
      region: json["region"],
      locale: json["locale"],
      currency: json["currency"],
    );
  }
}

class ResultStatus {
  ResultStatus({
    required this.code,
    required this.attempt,
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
  final int? attempt;
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

  factory ResultStatus.fromJson(Map<String, dynamic> json) {
    return ResultStatus(
      code: json["code"],
      attempt: json["attempt"],
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

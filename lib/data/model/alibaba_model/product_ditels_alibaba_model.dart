class ProductDitelsAliBabaModel {
  ProductDitelsAliBabaModel({required this.result});

  final Result? result;

  factory ProductDitelsAliBabaModel.fromJson(Map<String, dynamic> json) {
    return ProductDitelsAliBabaModel(
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }
}

class Result {
  Result({
    required this.status,
    required this.settings,
    required this.item,
    required this.seller,
    required this.company,
  });

  final Status? status;
  final Settings? settings;
  final Item? item;
  final Seller? seller;
  final Company? company;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      settings: json["settings"] == null
          ? null
          : Settings.fromJson(json["settings"]),
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
    required this.companyType,
    required this.companyEmployeesCount,
    required this.companyTransactionAmount,
    required this.companyContact,
  });

  final String? companyName;
  final int? companyId;
  final String? companyType;
  final dynamic companyEmployeesCount;
  final dynamic companyTransactionAmount;
  final CompanyContact? companyContact;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json["companyName"],
      companyId: json["companyId"],
      companyType: json["companyType"],
      companyEmployeesCount: json["companyEmployeesCount"],
      companyTransactionAmount: json["companyTransactionAmount"],
      companyContact: json["companyContact"] == null
          ? null
          : CompanyContact.fromJson(json["companyContact"]),
    );
  }
}

class CompanyContact {
  CompanyContact({required this.name});

  final String? name;

  factory CompanyContact.fromJson(Map<String, dynamic> json) {
    return CompanyContact(name: json["name"]);
  }
}

class Item {
  Item({
    required this.available,
    required this.itemId,
    required this.title,
    required this.catId,
    required this.itemUrl,
    required this.images,
    required this.video,
    required this.properties,
    required this.description,
    required this.sku,
  });

  final bool? available;
  final String? itemId;
  final String? title;
  final int? catId;
  final String? itemUrl;
  final List<String> images;
  final Video? video;
  final Properties? properties;
  final Description? description;
  final Sku? sku;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      available: json["available"],
      itemId: json["itemId"],
      title: json["title"],
      catId: json["catId"],
      itemUrl: json["itemUrl"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      video: json["video"] == null ? null : Video.fromJson(json["video"]),
      properties: json["properties"] == null
          ? null
          : Properties.fromJson(json["properties"]),
      description: json["description"] == null
          ? null
          : Description.fromJson(json["description"]),
      sku: json["sku"] == null ? null : Sku.fromJson(json["sku"]),
    );
  }
}

class Description {
  Description({required this.html, required this.images});

  final String? html;
  final List<String> images;

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      html: json["html"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
    );
  }
}

class Properties {
  Properties({required this.cut, required this.list});

  final String? cut;
  final List<ListElement> list;

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      cut: json["cut"],
      list: json["list"] == null
          ? []
          : List<ListElement>.from(
              json["list"]!.map((x) => ListElement.fromJson(x)),
            ),
    );
  }
}

class ListElement {
  ListElement({required this.name, required this.value});

  final String? name;
  final String? value;

  factory ListElement.fromJson(Map<String, dynamic> json) {
    return ListElement(name: json["name"], value: json["value"]);
  }
}

class Sku {
  Sku({required this.def, required this.base, required this.props});

  final Def? def;
  final List<Base> base;
  final List<Prop> props;

  factory Sku.fromJson(Map<String, dynamic> json) {
    return Sku(
      def: json["def"] == null ? null : Def.fromJson(json["def"]),
      base: json["base"] == null
          ? []
          : List<Base>.from(json["base"]!.map((x) => Base.fromJson(x))),
      props: json["props"] == null
          ? []
          : List<Prop>.from(json["props"]!.map((x) => Prop.fromJson(x))),
    );
  }
}

class Base {
  Base({required this.skuId, required this.propMap});

  final int? skuId;
  final String? propMap;

  factory Base.fromJson(Map<String, dynamic> json) {
    return Base(skuId: json["skuId"], propMap: json["propMap"]);
  }
}

class Def {
  Def({
    required this.priceModule,
    required this.quantityModule,
    required this.unitModule,
  });

  final PriceModule? priceModule;
  final QuantityModule? quantityModule;
  final UnitModule? unitModule;

  factory Def.fromJson(Map<String, dynamic> json) {
    return Def(
      priceModule: json["priceModule"] == null
          ? null
          : PriceModule.fromJson(json["priceModule"]),
      quantityModule: json["quantityModule"] == null
          ? null
          : QuantityModule.fromJson(json["quantityModule"]),
      unitModule: json["unitModule"] == null
          ? null
          : UnitModule.fromJson(json["unitModule"]),
    );
  }
}

class PriceModule {
  PriceModule({
    required this.currencyCode,
    required this.priceType,
    required this.priceList,
  });

  final String? currencyCode;
  final String? priceType;
  final List<PriceList> priceList;

  factory PriceModule.fromJson(Map<String, dynamic> json) {
    return PriceModule(
      currencyCode: json["currencyCode"],
      priceType: json["priceType"],
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
    required this.quantityFormatted,
  });

  final double? price;
  final String? priceFormatted;
  final int? minQuantity;
  final int? maxQuantity;
  final String? quantityFormatted;

  factory PriceList.fromJson(Map<String, dynamic> json) {
    return PriceList(
      price: (json["price"] ?? json["minPrice"])?.toDouble(),
      priceFormatted: json["priceFormatted"],
      minQuantity: (json["minQuantity"] ?? json["minPrice"])
          ?.toDouble()
          .toInt(),
      maxQuantity: (json["maxQuantity"] ?? json["maxPrice"])
          ?.toDouble()
          .toInt(),
      quantityFormatted: json["quantityFormatted"] ?? json["unit"],
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
    required this.quantityFormatted,
    required this.unit,
  });

  final int? quantity;
  final String? quantityFormatted;
  final String? unit;

  factory MinOrder.fromJson(Map<String, dynamic> json) {
    return MinOrder(
      quantity: json["quantity"],
      quantityFormatted: json["quantityFormatted"],
      unit: json["unit"],
    );
  }
}

class UnitModule {
  UnitModule({required this.single, required this.multi});

  final String? single;
  final String? multi;

  factory UnitModule.fromJson(Map<String, dynamic> json) {
    return UnitModule(single: json["single"], multi: json["multi"]);
  }
}

class Prop {
  Prop({required this.name, required this.values});

  final String? name;
  final List<Value> values;

  factory Prop.fromJson(Map<String, dynamic> json) {
    return Prop(
      name: json["name"],
      values: json["values"] == null
          ? []
          : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
    );
  }
}

class Value {
  Value({required this.id, required this.name, required this.image});

  final String? id;
  final String? name;
  final String? image;

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(id: json["id"], name: json["name"], image: json["image"]);
  }
}

class Video {
  Video({required this.id, required this.thumbnail, required this.url});

  final String? id;
  final String? thumbnail;
  final String? url;

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"],
      thumbnail: json["thumbnail"],
      url: json["url"],
    );
  }
}

class Seller {
  Seller({required this.sellerId});

  final int? sellerId;

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(sellerId: json["sellerId"]);
  }
}

class Settings {
  Settings({
    required this.locale,
    required this.currency,
    required this.country,
    required this.itemId,
  });

  final String? locale;
  final String? currency;
  final String? country;
  final String? itemId;

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      locale: json["locale"],
      currency: json["currency"],
      country: json["country"],
      itemId: json["itemId"],
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
  Debug({required this.apiProcessing});

  final ApiProcessing? apiProcessing;

  factory Debug.fromJson(Map<String, dynamic> json) {
    return Debug(
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

class ItemDetailsModel {
  ItemDetailsModel({required this.result});

  final Result? result;

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailsModel(
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }
}

class Result {
  Result({
    required this.status,
    required this.settings,
    required this.item,
    required this.reviews,
    required this.delivery,
    required this.seller,
  });

  final Status? status;
  final Settings? settings;
  final Item? item;
  final Reviews? reviews;
  final Delivery? delivery;
  final Seller? seller;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      settings: json["settings"] == null
          ? null
          : Settings.fromJson(json["settings"]),
      item: json["item"] == null ? null : Item.fromJson(json["item"]),
      reviews: json["reviews"] == null
          ? null
          : Reviews.fromJson(json["reviews"]),
      delivery: json["delivery"] == null
          ? null
          : Delivery.fromJson(json["delivery"]),
      seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    );
  }
}

class Delivery {
  Delivery({
    required this.shippingToCode,
    required this.shippingOutDays,
    required this.shippingList,
    required this.packageDetail,
  });

  final String? shippingToCode;
  final int? shippingOutDays;
  final dynamic shippingList;
  final PackageDetail? packageDetail;

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      shippingToCode: json["shippingToCode"],
      shippingOutDays: json["shippingOutDays"],
      shippingList: json["shippingList"],
      packageDetail: json["packageDetail"] == null
          ? null
          : PackageDetail.fromJson(json["packageDetail"]),
    );
  }
}

class PackageDetail {
  PackageDetail({
    required this.weight,
    required this.length,
    required this.height,
    required this.width,
  });

  final String? weight;
  final int? length;
  final int? height;
  final int? width;

  factory PackageDetail.fromJson(Map<String, dynamic> json) {
    return PackageDetail(
      weight: json["weight"],
      length: json["length"],
      height: json["height"],
      width: json["width"],
    );
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
  final int? itemId;
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
  Sku({
    required this.def,
    required this.base,
    required this.props,
    required this.skuImages,
  });

  final Def? def;
  final List<Base> base;
  final List<Prop> props;
  final SkuImages? skuImages;

  /// Robust factory: accepts Map, List, null, or String JSON.
  factory Sku.fromJson(dynamic json) {
    // If null -> return empty/nullable fields
    if (json == null) {
      return Sku(def: null, base: [], props: [], skuImages: null);
    }

    // If the API gave a List, try to use the first element if it's a Map
    if (json is List) {
      if (json.isEmpty) {
        return Sku(def: null, base: [], props: [], skuImages: null);
      }
      final first = json.first;
      if (first is Map<String, dynamic>) {
        json = Map<String, dynamic>.from(first);
      } else {
        // not map inside list -> can't parse -> return empty safe object
        return Sku(def: null, base: [], props: [], skuImages: null);
      }
    }

    // At this point we expect a Map
    if (json is! Map<String, dynamic>) {
      return Sku(def: null, base: [], props: [], skuImages: null);
    }

    final map = json;

    // def could be Map or List
    final defRaw = map['def'];
    Def? defObj;
    if (defRaw is Map<String, dynamic>) {
      defObj = Def.fromJson(defRaw);
    } else if (defRaw is List &&
        defRaw.isNotEmpty &&
        defRaw.first is Map<String, dynamic>) {
      defObj = Def.fromJson(defRaw.first as Map<String, dynamic>);
    }

    // base may be List or a single Map
    final baseRaw = map['base'];
    List<Base> baseList = [];
    if (baseRaw is List) {
      baseList = baseRaw
          .where((e) => e is Map<String, dynamic>)
          .map((e) => Base.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } else if (baseRaw is Map<String, dynamic>) {
      baseList = [Base.fromJson(Map<String, dynamic>.from(baseRaw))];
    }

    // props may be List or Map
    final propsRaw = map['props'];
    List<Prop> propsList = [];
    if (propsRaw is List) {
      propsList = propsRaw
          .where((e) => e is Map<String, dynamic>)
          .map((e) => Prop.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } else if (propsRaw is Map<String, dynamic>) {
      propsList = [Prop.fromJson(Map<String, dynamic>.from(propsRaw))];
    }

    // skuImages likely Map
    SkuImages? skuImgs;
    final skuImagesRaw = map['skuImages'];
    if (skuImagesRaw is Map<String, dynamic>) {
      skuImgs = SkuImages.fromJson(Map<String, dynamic>.from(skuImagesRaw));
    }

    return Sku(
      def: defObj,
      base: baseList,
      props: propsList,
      skuImages: skuImgs,
    );
  }
}

class Base {
  Base({
    required this.skuId,
    required this.skuAttr,
    required this.propMap,
    required this.price,
    required this.promotionPrice,
    required this.quantity,
    required this.ext,
  });

  final String? skuId;
  final String? skuAttr;
  final String? propMap;
  final String? price;
  final String? promotionPrice;
  final int? quantity;
  final String? ext;

  factory Base.fromJson(Map<String, dynamic> json) {
    return Base(
      skuId: json["skuId"],
      skuAttr: json["skuAttr"],
      propMap: json["propMap"],
      price: json["price"],
      promotionPrice: json["promotionPrice"],
      quantity: json["quantity"],
      ext: json["ext"],
    );
  }
}

class Def {
  Def({
    required this.quantity,
    required this.price,
    required this.promotionPrice,
  });

  final int? quantity;
  final String? price;
  final String? promotionPrice;

  factory Def.fromJson(Map<String, dynamic> json) {
    return Def(
      quantity: json["quantity"],
      price: json["price"],
      promotionPrice: json["promotionPrice"],
    );
  }
}

class Prop {
  Prop({required this.pid, required this.name, required this.values});

  final int? pid;
  final String? name;
  final List<Value> values;

  factory Prop.fromJson(Map<String, dynamic> json) {
    return Prop(
      pid: json["pid"],
      name: json["name"],
      values: json["values"] == null
          ? []
          : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
    );
  }
}

class Value {
  Value({required this.vid, required this.name, required this.image});

  final int? vid;
  final String? name;
  final String? image;

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(vid: json["vid"], name: json["name"], image: json["image"]);
  }
}

class SkuImages {
  SkuImages({
    required this.the14365458,
    required this.the14100018786,
    required this.the14771,
    required this.the141254,
    required this.the14193,
    required this.the14173,
  });

  final String? the14365458;
  final String? the14100018786;
  final String? the14771;
  final String? the141254;
  final String? the14193;
  final String? the14173;

  factory SkuImages.fromJson(Map<String, dynamic> json) {
    return SkuImages(
      the14365458: json["14:365458"],
      the14100018786: json["14:100018786"],
      the14771: json["14:771"],
      the141254: json["14:1254"],
      the14193: json["14:193"],
      the14173: json["14:173"],
    );
  }
}

class Reviews {
  Reviews({required this.count, required this.averageStar});

  final String? count;
  final String? averageStar;

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(count: json["count"], averageStar: json["averageStar"]);
  }
}

class Seller {
  Seller({
    required this.storeTitle,
    required this.storeId,
    required this.storeUrl,
  });

  final String? storeTitle;
  final int? storeId;
  final String? storeUrl;

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      storeTitle: json["storeTitle"],
      storeId: json["storeId"],
      storeUrl: json["storeUrl"],
    );
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

class Video {
  Video({required this.id, required this.thumbnail, required this.url});

  final int? id;
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

class Status {
  Status({
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

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
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

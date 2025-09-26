class SearchFromCatModel {
  Result? result;

  SearchFromCatModel({this.result});

  SearchFromCatModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? new Result.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  Status? status;
  Settings? settings;
  Base? base;
  List<ResultList>? resultList;

  Result({this.status, this.settings, this.base, this.resultList});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null
        ? new Status.fromJson(json['status'])
        : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    base = json['base'] != null ? new Base.fromJson(json['base']) : null;
    if (json['resultList'] != null) {
      resultList = <ResultList>[];
      json['resultList'].forEach((v) {
        resultList!.add(new ResultList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.base != null) {
      data['base'] = this.base!.toJson();
    }
    if (this.resultList != null) {
      data['resultList'] = this.resultList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  int? code;
  String? data;
  String? executionTime;
  String? requestTime;
  String? requestId;
  String? endpoint;
  String? apiVersion;
  String? functionsVersion;
  String? la;
  int? pmu;
  int? mu;

  Status({
    this.code,
    this.data,
    this.executionTime,
    this.requestTime,
    this.requestId,
    this.endpoint,
    this.apiVersion,
    this.functionsVersion,
    this.la,
    this.pmu,
    this.mu,
  });

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'];
    executionTime = json['executionTime'];
    requestTime = json['requestTime'];
    requestId = json['requestId'];
    endpoint = json['endpoint'];
    apiVersion = json['apiVersion'];
    functionsVersion = json['functionsVersion'];
    la = json['la'];
    pmu = json['pmu'];
    mu = json['mu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['data'] = this.data;
    data['executionTime'] = this.executionTime;
    data['requestTime'] = this.requestTime;
    data['requestId'] = this.requestId;
    data['endpoint'] = this.endpoint;
    data['apiVersion'] = this.apiVersion;
    data['functionsVersion'] = this.functionsVersion;
    data['la'] = this.la;
    data['pmu'] = this.pmu;
    data['mu'] = this.mu;
    return data;
  }
}

class Settings {
  String? q;
  String? catId;
  String? sort;
  String? page;
  String? startPrice;
  String? endPrice;
  String? region;
  String? locale;
  String? currency;

  Settings({
    this.q,
    this.catId,
    this.sort,
    this.page,
    this.startPrice,
    this.endPrice,
    this.region,
    this.locale,
    this.currency,
  });

  Settings.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    catId = json['catId'];
    sort = json['sort'];
    page = json['page'];
    startPrice = json['startPrice'];
    endPrice = json['endPrice'];
    region = json['region'];
    locale = json['locale'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q'] = this.q;
    data['catId'] = this.catId;
    data['sort'] = this.sort;
    data['page'] = this.page;
    data['startPrice'] = this.startPrice;
    data['endPrice'] = this.endPrice;
    data['region'] = this.region;
    data['locale'] = this.locale;
    data['currency'] = this.currency;
    return data;
  }
}

class Base {
  int? totalResults;
  int? pageSize;
  int? page;
  List<String>? sortValues;

  Base({this.totalResults, this.pageSize, this.page, this.sortValues});

  Base.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    pageSize = json['pageSize'];
    page = json['page'];
    sortValues = json['sortValues'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['pageSize'] = this.pageSize;
    data['page'] = this.page;
    data['sortValues'] = this.sortValues;
    return data;
  }
}

class ResultList {
  Item? item;

  ResultList({this.item});

  ResultList.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  int? itemId;
  String? title;
  int? sales;
  String? itemUrl;
  String? image;
  String? video;
  Sku? sku;

  Item({
    this.itemId,
    this.title,
    this.sales,
    this.itemUrl,
    this.image,
    this.video,
    this.sku,
  });

  Item.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    title = json['title'];
    sales = json['sales'];
    itemUrl = json['itemUrl'];
    image = json['image'];
    video = json['video'];
    sku = json['sku'] != null ? new Sku.fromJson(json['sku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['title'] = this.title;
    data['sales'] = this.sales;
    data['itemUrl'] = this.itemUrl;
    data['image'] = this.image;
    data['video'] = this.video;
    if (this.sku != null) {
      data['sku'] = this.sku!.toJson();
    }
    return data;
  }
}

class Sku {
  Def? def;

  Sku({this.def});

  Sku.fromJson(Map<String, dynamic> json) {
    def = json['def'] != null ? new Def.fromJson(json['def']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.def != null) {
      data['def'] = this.def!.toJson();
    }
    return data;
  }
}

class Def {
  String? price;
  String? promotionPrice;

  Def({this.price, this.promotionPrice});

  Def.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    promotionPrice = json['promotionPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['promotionPrice'] = this.promotionPrice;
    return data;
  }
}

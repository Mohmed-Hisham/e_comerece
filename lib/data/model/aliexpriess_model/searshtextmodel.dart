class SearshTextModel {
  ResultSearshTextModel? resultSearshTextModel;

  SearshTextModel({this.resultSearshTextModel});

  SearshTextModel.fromJson(Map<String, dynamic> json) {
    resultSearshTextModel = json['result'] != null
        ? ResultSearshTextModel.fromJson(json['result'])
        : null;
  }
}

class ResultSearshTextModel {
  Status? status;
  Settings? settings;
  Base? base;
  List<ResultListSearshTextModel>? resultListSearshTextModel;

  ResultSearshTextModel({
    this.status,
    this.settings,
    this.base,
    this.resultListSearshTextModel,
  });

  ResultSearshTextModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
    base = json['base'] != null ? Base.fromJson(json['base']) : null;
    if (json['resultList'] != null) {
      resultListSearshTextModel = <ResultListSearshTextModel>[];
      json['resultList'].forEach((v) {
        resultListSearshTextModel!.add(ResultListSearshTextModel.fromJson(v));
      });
    }
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
}

class ResultListSearshTextModel {
  Item? item;

  ResultListSearshTextModel({this.item});

  ResultListSearshTextModel.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
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
    sku = json['sku'] != null ? Sku.fromJson(json['sku']) : null;
  }
}

class Sku {
  Def? def;

  Sku({this.def});

  Sku.fromJson(Map<String, dynamic> json) {
    def = json['def'] != null ? Def.fromJson(json['def']) : null;
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
}

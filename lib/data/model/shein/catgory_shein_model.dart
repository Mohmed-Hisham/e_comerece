class CatgorySheinModel {
  CatgorySheinModel({
    required this.success,
    required this.message,
    required this.data,
    required this.error,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;
  final dynamic error;

  factory CatgorySheinModel.fromJson(Map<String, dynamic> json) {
    return CatgorySheinModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      error: json["error"],
    );
  }
}

class Datum {
  Datum({
    required this.children,
    required this.catId,
    required this.catName,
    required this.goodsTypeId,
    required this.parentId,
    required this.cateCorrelation,
  });

  final List<Child> children;
  final String? catId;
  final String? catName;
  final dynamic goodsTypeId;
  final String? parentId;
  final String? cateCorrelation;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      children: json["children"] == null
          ? []
          : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
      catId: json["cat_id"],
      catName: json["cat_name"],
      goodsTypeId: json["goods_type_id"],
      parentId: json["parent_id"],
      cateCorrelation: json["cateCorrelation"],
    );
  }
}

class Child {
  Child({
    required this.children,
    required this.catId,
    required this.catName,
    required this.urlCatId,
    required this.catUrlName,
    required this.goodsTypeId,
    required this.parentId,
    required this.isLeaf,
    required this.cateCorrelation,
  });

  final List<Child> children;
  final String? catId;
  final String? catName;
  final dynamic urlCatId;
  final dynamic catUrlName;
  final dynamic goodsTypeId;
  final String? parentId;
  final String? isLeaf;
  final String? cateCorrelation;

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      children: json["children"] == null
          ? []
          : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
      catId: json["cat_id"],
      catName: json["cat_name"],
      urlCatId: json["url_cat_id"],
      catUrlName: json["cat_url_name"],
      goodsTypeId: json["goods_type_id"],
      parentId: json["parent_id"],
      isLeaf: json["is_leaf"],
      cateCorrelation: json["cateCorrelation"],
    );
  }
}

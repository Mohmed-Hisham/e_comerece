class FavoriteModel {
  String? favoriteId;
  String? productId;
  String? productTitle;
  String? productImage;
  String? productPrice;
  String? platform;

  FavoriteModel({
    this.favoriteId,
    this.productId,
    this.productTitle,
    this.productImage,
    this.productPrice,
    this.platform,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    favoriteId = json['favorite_id'];
    productId = json['productId'];
    productTitle = json['product_title'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    platform = json['favorite_platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favorite_id'] = favoriteId;
    data['productId'] = productId;
    data['product_title'] = productTitle;
    data['product_image'] = productImage;
    data['product_price'] = productPrice;
    data['favorite_platform'] = platform;
    return data;
  }
}

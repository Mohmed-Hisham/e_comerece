class CartModel {
  int? cartId;
  String? productId;
  String? cartProductTitle;
  String? cartProductImage;
  String? cartPrice;
  int? cartQuantity;
  String? cartAttributes;
  int? cartAvailableQuantity;
  String? cartPlatform;
  String? goodsSn;
  String? categoryId;
  String? productink;

  CartModel({
    this.cartId,
    this.productId,
    this.cartProductTitle,
    this.cartProductImage,
    this.cartPrice,
    this.cartQuantity,
    this.cartAttributes,
    this.cartAvailableQuantity,
    this.cartPlatform,
    this.goodsSn,
    this.categoryId,
    this.productink,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['productId'];
    cartProductTitle = json['cart_product_title'];
    cartProductImage = json['cart_product_image'];
    cartPrice = json['cart_price'];
    cartQuantity = json['cart_quantity'];
    cartAttributes = json['cart_attributes'];
    cartAvailableQuantity = json['cart_available_quantity'];
    cartPlatform = json['cart_platform'];
    goodsSn = json['goods_sn'];
    categoryId = json['category_id'];
    productink = json['product_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['productId'] = productId;
    data['cart_product_title'] = cartProductTitle;
    data['cart_product_image'] = cartProductImage;
    data['cart_price'] = cartPrice;
    data['cart_quantity'] = cartQuantity;
    data['cart_attributes'] = cartAttributes;
    data['cart_available_quantity'] = cartAvailableQuantity;
    data['cart_platform'] = cartPlatform;
    data['goods_sn'] = goodsSn;
    data['category_id'] = categoryId;
    data['product_link'] = productink;
    return data;
  }
}

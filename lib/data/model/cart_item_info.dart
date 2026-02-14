class CartItemInfo {
  final int quantity;
  final bool inFavorite;
  final bool inCart;

  CartItemInfo({
    required this.quantity,
    required this.inFavorite,
    required this.inCart,
  });

  factory CartItemInfo.fromJson(Map<String, dynamic> json) {
    return CartItemInfo(
      quantity: json['quantity'] as int? ?? 0,
      inFavorite: json['in_favorite'] as bool? ?? false,
      inCart: (json['quantity'] as int? ?? 0) > 0,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/cartmodel.dart';

abstract class CartRepo {
  Future<Either<Failure, CartModel>> getCart();
  Future<Either<Failure, String>> addCart(CartData cartData);
  Future<Either<Failure, String>> deleteCart(String cartId);
  Future<Either<Failure, Map<String, dynamic>>> getQuantity(
    String productId,
    String? attributes,
  );
  Future<Either<Failure, String>> increaseQuantity(
    String productId,
    String? attributes,
    int availableQuantity,
  );
  Future<Either<Failure, String>> decreaseQuantity(
    String productId,
    String? attributes,
    int availableQuantity,
  );
}

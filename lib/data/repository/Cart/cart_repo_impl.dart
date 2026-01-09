import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/repository/Cart/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final ApiService apiService;
  CartRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, CartModel>> getCart() async {
    try {
      var response = await apiService.get(endpoint: ApisUrl.getUserCart);
      if (response.statusCode == 200) {
        return Right(CartModel.fromJson(response.data));
      } else {
        return Left(
          ServerFailure(response.data['message'] ?? "Error occurred"),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addCart(CartData cartData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.addCart,
        data: cartData.toAddJson(),
      );
      if (response.statusCode == 200) {
        return Right(response.data['message'] ?? "Added to cart");
      } else {
        return Left(
          ServerFailure(response.data['message'] ?? "Error occurred"),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteCart(String cartId) async {
    try {
      var response = await apiService.delete(
        endPoints: ApisUrl.removeCart(cartId),
      );
      if (response.statusCode == 200) {
        return Right(response.data['message'] ?? "Removed from cart");
      } else {
        return Left(
          ServerFailure(response.data['message'] ?? "Error occurred"),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getQuantity(
    String productId,
    String? attributes,
  ) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.getQuantity,
        data: {"product_id": productId, "attributes": attributes},
      );
      if (response.statusCode == 200) {
        return Right(response.data['data'] ?? {});
      } else {
        return Left(
          ServerFailure(response.data['message'] ?? "Error occurred"),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> increaseQuantity(
    String productId,
    String? attributes,
    int availableQuantity,
  ) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.increaseQuantity,
        data: {
          "product_id": productId,
          "attributes": attributes,
          "available_quantity": availableQuantity,
        },
      );
      if (response.statusCode == 200) {
        return Right(response.data['message'] ?? "Quantity increased");
      } else {
        return Left(
          ServerFailure(response.data['message'] ?? "Error occurred"),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> decreaseQuantity(
    String productId,
    String? attributes,
    int availableQuantity,
  ) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.decreaseQuantity,
        data: {
          "product_id": productId,
          "attributes": attributes,
          "available_quantity": availableQuantity,
        },
      );
      if (response.statusCode == 200) {
        return Right(response.data['message'] ?? "Quantity decreased");
      } else {
        return Left(
          ServerFailure(response.data['message'] ?? "Error occurred"),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

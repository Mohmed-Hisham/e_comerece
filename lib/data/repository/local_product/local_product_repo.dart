import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/our_product_model.dart';

abstract class LocalProductRepo {
  /// Get all product categories
  Future<Either<Failure, List<LocalProductCategoryModel>>> getCategories();

  /// Get all products with pagination
  Future<Either<Failure, LocalProductsResponse>> getProducts({
    required int page,
    required int pageSize,
  });

  /// Get products by category with pagination
  Future<Either<Failure, LocalProductsResponse>> getProductsByCategory({
    required String categoryId,
    required int page,
    required int pageSize,
  });

  /// Get single product details with related products
  Future<Either<Failure, LocalProductDetailsResponse>> getProductById({
    required String productId,
    int relatedPage = 1,
    int relatedPageSize = 4,
  });

  /// Search products
  Future<Either<Failure, LocalProductsResponse>> searchProducts({
    required String query,
    required int page,
    required int pageSize,
  });
}

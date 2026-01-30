import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/our_product_model.dart';
import 'package:e_comerece/data/repository/local_product/local_product_repo.dart';

class LocalProductRepoImpl implements LocalProductRepo {
  final ApiService apiService;
  LocalProductRepoImpl({required this.apiService});

  static const String _errorMsg = "An error occurred";

  @override
  Future<Either<Failure, List<LocalProductCategoryModel>>>
  getCategories() async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getLocalProductCategories,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> dataList = response.data['data'] ?? [];
        final categories = dataList
            .map((e) => LocalProductCategoryModel.fromJson(e))
            .toList();
        return Right(categories);
      } else {
        return Left(ServerFailure(response.data['message'] ?? _errorMsg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocalProductsResponse>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getLocalProducts(page: page, pageSize: pageSize),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final productsResponse = LocalProductsResponse.fromJson(
          response.data['data'] ?? {},
        );
        return Right(productsResponse);
      } else {
        return Left(ServerFailure(response.data['message'] ?? _errorMsg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocalProductsResponse>> getProductsByCategory({
    required String categoryId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getLocalProductsByCategory(
          categoryId: categoryId,
          page: page,
          pageSize: pageSize,
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final productsResponse = LocalProductsResponse.fromJson(
          response.data['data'] ?? {},
        );
        return Right(productsResponse);
      } else {
        return Left(ServerFailure(response.data['message'] ?? _errorMsg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocalProductDetailsResponse>> getProductById({
    required String productId,
    int relatedPage = 1,
    int relatedPageSize = 4,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getLocalProductById(
          productId: productId,
          relatedPage: relatedPage,
          relatedPageSize: relatedPageSize,
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final detailsResponse = LocalProductDetailsResponse.fromJson(
          response.data['data'] ?? {},
        );
        return Right(detailsResponse);
      } else {
        return Left(ServerFailure(response.data['message'] ?? _errorMsg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocalProductsResponse>> searchProducts({
    required String query,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.searchLocalProducts(
          query: query,
          page: page,
          pageSize: pageSize,
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final productsResponse = LocalProductsResponse.fromJson(
          response.data['data'] ?? {},
        );
        return Right(productsResponse);
      } else {
        return Left(ServerFailure(response.data['message'] ?? _errorMsg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

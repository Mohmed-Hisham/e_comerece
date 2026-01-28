import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/data/Apis/alibaba_urls.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_byimage_model.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:e_comerece/data/model/alibaba_model/product_ditels_alibaba_model.dart';
import 'package:e_comerece/data/repository/alibaba/alibaba_repo.dart';

class AlibabaRepoImpl implements AlibabaRepo {
  final ApiService apiService;
  AlibabaRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, ProductAliBabaHomeModel>> fetchProducts(
    String lang,
    int page,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AlibabaUrls.hotProducts(
          lang,
          page,
          "fashion",
          "1",
          "1000",
          "",
        ),
      );
      if (response.statusCode == 200) {
        return Right(ProductAliBabaHomeModel.fromJson(response.data['data']));
      } else {
        return Left(ServerFailure(response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductAliBabaHomeModel>> searchProducts(
    String lang,
    int page,
    String keyword,
    String startPrice,
    String endPrice,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AlibabaUrls.hotProducts(
          lang,
          page,
          keyword,
          startPrice,
          endPrice,
          "",
        ),
      );
      if (response.statusCode == 200) {
        return Right(ProductAliBabaHomeModel.fromJson(response.data['data']));
      } else {
        return Left(ServerFailure(response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductAliBabaByImageModel>> fetchSearchByImage(
    String lang,
    String imageUrl,
    int page,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AlibabaUrls.searchByImage(lang, imageUrl, page),
      );
      if (response.statusCode == 200) {
        return Right(
          ProductAliBabaByImageModel.fromJson(response.data['data']),
        );
      } else {
        return Left(ServerFailure(response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDitelsAliBabaModel>> fetchProductDetails(
    String lang,
    String productId,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AlibabaUrls.details(lang, productId),
      );
      if (response.statusCode == 200) {
        return Right(ProductDitelsAliBabaModel.fromJson(response.data['data']));
      } else {
        return Left(ServerFailure(response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

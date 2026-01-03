import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/shein_urls.dart';
import 'package:e_comerece/data/model/shein_models/catgory_shein_model.dart';
import 'package:e_comerece/data/model/shein_models/details_shein_image_list.dart';
import 'package:e_comerece/data/model/shein_models/details_shein_size.dart';
import 'package:e_comerece/data/model/shein_models/product_ditels_shein_model.dart';
import 'package:e_comerece/data/model/shein_models/searsh_shein_model.dart';
import 'package:e_comerece/data/model/shein_models/trending_products_model.dart';
import 'package:e_comerece/data/repository/shein/shein_repo.dart';

class SheinRepoImpl implements SheinRepo {
  final ApiService apiService;
  SheinRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, TrendingProductsModel>> fetchTrendingProducts(
    String lang,
    int page,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: SheinUrls.trending(lang, page),
      );
      if (response.statusCode == 200) {
        return Right(TrendingProductsModel.fromJson(response.data["data"]));
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
  Future<Either<Failure, SeachSheinModel>> searchProducts(
    String lang,
    String keyword,
    int page,
    String startPrice,
    String endPrice,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: SheinUrls.search(lang, keyword, page, startPrice, endPrice),
      );
      if (response.statusCode == 200) {
        return Right(SeachSheinModel.fromJson(response.data["data"]));
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
  Future<Either<Failure, CatgorySheinModel>> fetchCategories(
    String lang,
  ) async {
    try {
      var response = await apiService.get(endpoint: SheinUrls.categories(lang));
      if (response.statusCode == 200) {
        return Right(CatgorySheinModel.fromJson(response.data["data"]));
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
  Future<Either<Failure, ProductDitelsSheinDart>> fetchProductDetails(
    String goodssn,
    String lang,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: SheinUrls.productDitels(goodssn, lang),
      );
      if (response.statusCode == 200) {
        return Right(ProductDitelsSheinDart.fromJson(response.data["data"]));
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
  Future<Either<Failure, DetailsSheinImageList>> fetchProductDetailsImageList(
    String goodssn,
    String lang,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: SheinUrls.productDitelsImageList(goodssn, lang),
      );
      if (response.statusCode == 200) {
        return Right(DetailsSheinImageList.fromJson(response.data["data"]));
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
  Future<Either<Failure, DetailsSheinSize>> fetchProductDetailsSize(
    String goodsid,
    String lang,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: SheinUrls.productDitelsSize(goodsid, lang),
      );
      if (response.statusCode == 200) {
        return Right(DetailsSheinSize.fromJson(response.data["data"]));
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
  Future<Either<Failure, SeachSheinModel>> fetchProductsByCategories(
    String categoryId,
    String categoryName,
    String pageindex,
    String countryCode,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: SheinUrls.productByCategories(
          categoryId,
          pageindex,
          countryCode,
          categoryName,
        ),
      );
      if (response.statusCode == 200) {
        return Right(SeachSheinModel.fromJson(response.data["data"]));
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

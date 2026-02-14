import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/data/Apis/amazon_urls.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/amazon_models/categories_amazon_model.dart';
import 'package:e_comerece/data/model/amazon_models/hotdeals_amazon_model.dart';
import 'package:e_comerece/data/model/amazon_models/details_amazon_model.dart';
import 'package:e_comerece/data/model/amazon_models/search_amazon_model.dart';
import 'package:e_comerece/data/repository/amazon/amazon_repo.dart';

class AmazonRepoImpl implements AmazonRepo {
  final ApiService apiService;
  AmazonRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, CategoriesAmazonModel>> fetchCategories(
    String lang,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AmazonUrls.categories(lang),
      );
      log(response.toString());
      if (response.statusCode == 200) {
        return Right(CategoriesAmazonModel.fromJson(response.data["data"]));
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
  Future<Either<Failure, HotDealsAmazonModel>> fetchHotDeals(
    String lang,
  ) async {
    try {
      var response = await apiService.get(endpoint: AmazonUrls.hotdeals(lang));
      if (response.statusCode == 200) {
        return Right(HotDealsAmazonModel.fromJson(response.data["data"]));
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
  Future<Either<Failure, SearchAmazonModel>> searchProducts(
    String lang,
    String keyword,
    int page,
    String startPrice,
    String endPrice,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AmazonUrls.search(lang, keyword, page, startPrice, endPrice),
      );
      if (response.statusCode == 200) {
        return Right(SearchAmazonModel.fromJson(response.data["data"]));
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
  Future<Either<Failure, DetailsAmazonModel>> fetchProductDetails(
    String asin,
    String lang,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AmazonUrls.details(lang, asin),
      );
      if (response.statusCode == 200) {
        return Right(DetailsAmazonModel.fromJson(response.data["data"]));
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

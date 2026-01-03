import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/data/Apis/aliexpriss_urls.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/aliexpriess_model/category_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/hotproductmodel.dart';
import 'package:e_comerece/data/model/aliexpriess_model/itemdetelis_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/searchbyimage_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/shearch_model.dart';
import 'package:e_comerece/data/repository/aliexpriss/alexpress_repo.dart';

class AlexpressRepoImpl implements AlexpressRepo {
  final ApiService apiService;
  AlexpressRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, CategorisModel>> fetchCategories(String lang) async {
    try {
      var response = await apiService.get(
        endpoint: AliexprissUrls.categories(lang),
      );
      if (response.statusCode == 200) {
        return Right(CategorisModel.fromJson(response.data));
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
  Future<Either<Failure, HotProductModel>> fetchProducts(
    String lang,
    int page,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AliexprissUrls.hotProducts(lang, page, "women fashion"),
      );
      if (response.statusCode == 200) {
        return Right(HotProductModel.fromJson(response.data['data']));
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
  Future<Either<Failure, HotProductModel>> searchProducts(
    String lang,
    int page,
    String keyword,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AliexprissUrls.hotProducts(lang, page, keyword),
      );
      if (response.statusCode == 200) {
        return Right(HotProductModel.fromJson(response.data['data']));
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
  Future<Either<Failure, SearchByImageModel>> fetchSearchByImage(
    String lang,
    String imageUrl,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AliexprissUrls.searchByImage(lang, imageUrl),
      );
      if (response.statusCode == 200) {
        return Right(SearchByImageModel.fromJson(response.data['data']));
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
  Future<Either<Failure, SearchFromCatModel>> searchByName(
    String lang,
    String keyword,
    int page,
    int categoryId,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AliexprissUrls.search(lang, keyword, page, categoryId),
      );
      if (response.statusCode == 200) {
        return Right(SearchFromCatModel.fromJson(response.data['data']));
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
  Future<Either<Failure, ItemDetailsModel>> fetchProductDetails(
    String lang,
    int productId,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: AliexprissUrls.details(lang, productId),
      );
      if (response.statusCode == 200) {
        return Right(ItemDetailsModel.fromJson(response.data['data']));
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

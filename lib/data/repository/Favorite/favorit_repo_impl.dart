import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:e_comerece/data/repository/Favorite/favorit_repo.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final ApiService apiService;
  FavoriteRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, FavoriteModel>> getAll() async {
    try {
      var response = await apiService.get(endpoint: ApisUrl.getUserFavorites());
      if (response.statusCode == 200) {
        return Right(FavoriteModel.fromJson(response.data));
      } else {
        String msg = "Error occurred";
        if (response.data is Map) {
          msg = response.data["message"] ?? msg;
        } else if (response.data is String) {
          msg = response.data;
        }
        return Left(ServerFailure(msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoriteModel>> getByPlatform(String platform) async {
    try {
      var response = await apiService.get(
        endpoint: ApisUrl.getUserFavorites(platform: platform),
      );
      if (response.statusCode == 200) {
        return Right(FavoriteModel.fromJson(response.data));
      } else {
        String msg = "Error occurred";
        if (response.data is Map) {
          msg = response.data["message"] ?? msg;
        } else if (response.data is String) {
          msg = response.data;
        }
        return Left(ServerFailure(msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> add(Product product) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.addFavorite,
        data: product.toJson(),
      );
      if (response.statusCode == 200) {
        String msg = "Success";
        if (response.data is Map) {
          msg = response.data["message"] ?? msg;
        } else if (response.data is String) {
          msg = response.data;
        }
        return Right(msg);
      } else {
        String msg = "Error occurred";
        if (response.data is Map) {
          msg = response.data["message"] ?? msg;
        } else if (response.data is String) {
          msg = response.data;
        }
        return Left(ServerFailure(msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> delete(String favoriteId) async {
    try {
      var response = await apiService.delete(
        endPoints: ApisUrl.favoritDelete(favoriteId),
      );
      if (response.statusCode == 200) {
        String msg = "Success";
        if (response.data is Map) {
          msg = response.data["message"] ?? msg;
        } else if (response.data is String) {
          msg = response.data;
        }
        return Right(msg);
      } else {
        String msg = "Error occurred";
        if (response.data is Map) {
          msg = response.data["message"] ?? msg;
        } else if (response.data is String) {
          msg = response.data;
        }
        return Left(ServerFailure(msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

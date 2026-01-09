import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/coupon_model/get_coupon_model.dart';
import 'package:e_comerece/data/repository/Coupon/coupon_repo.dart';
import 'package:dio/dio.dart';

class CouponRepoImpl implements CouponRepo {
  final ApiService apiService;

  CouponRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, CouponResponse>> getCoupon({
    required String code,
  }) async {
    try {
      var response = await apiService.get(endpoint: ApisUrl.getCoupon(code));
      if (response.statusCode == 200) {
        return Right(CouponResponse.fromJson(response.data));
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
  Future<Either<Failure, CouponResponse>> useCoupon({
    required String code,
    required String orderid,
  }) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.useCoupon,
        data: {"code": code, "order_id": orderid},
      );
      if (response.statusCode == 200) {
        return Right(CouponResponse.fromJson(response.data));
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

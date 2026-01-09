import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/checkout/checkout_review_fee_model.dart';
import 'package:e_comerece/data/repository/Checkout/checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final ApiService apiService;
  static const msg = 'Something went wrong';

  CheckoutRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, CheckoutReviewFeeModel>> getCheckOutReviewFee() async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getCheckOutReviewFee,
      );
      if (response.statusCode == 200) {
        return Right(CheckoutReviewFeeModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message'] ?? msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

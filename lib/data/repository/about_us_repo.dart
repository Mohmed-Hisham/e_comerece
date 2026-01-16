import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/about_us_model.dart';

abstract class AboutUsRepo {
  Future<Either<Failure, AboutUsModel>> getAboutUs();
}

class AboutUsRepoImpl extends AboutUsRepo {
  final ApiService apiService;

  AboutUsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, AboutUsModel>> getAboutUs() async {
    try {
      final response = await apiService.get(endpoint: ApisUrl.getAboutUs);
      if (response.statusCode == 200) {
        return Right(AboutUsModel.fromJson(response.data));
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

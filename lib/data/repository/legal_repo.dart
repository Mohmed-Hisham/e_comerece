import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/legal_model.dart';

abstract class LegalRepo {
  Future<Either<Failure, LegalModel>> getLegalContent();
}

class LegalRepoImpl extends LegalRepo {
  final ApiService apiService;

  LegalRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, LegalModel>> getLegalContent() async {
    try {
      final response = await apiService.get(endpoint: ApisUrl.getLegal);
      if (response.statusCode == 200) {
        return Right(LegalModel.fromJson(response.data));
      } else {
        return Left(
          ServerFailure(
            response.data['Message'] ??
                response.data['message'] ??
                "Error occurred",
          ),
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

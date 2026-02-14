import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/user_profile_model.dart';
import 'package:e_comerece/data/repository/user_profile/user_profile_repo.dart';

class UserProfileRepoImpl implements UserProfileRepo {
  final ApiService apiService;
  UserProfileRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, UserProfileResponse>> getUserProfile() async {
    try {
      var response = await apiService.get(endpoint: ApisUrl.getUserProfile);
      if (response.statusCode == 200) {
        return Right(UserProfileResponse.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileResponse>> updateUserProfile({
    String? name,
    String? phone,
  }) async {
    try {
      final data = UserProfileData(name: name, phone: phone).toJson();
      var response = await apiService.put(
        endPoints: ApisUrl.updateUserProfile,
        data: data,
      );
      if (response.statusCode == 200) {
        return Right(UserProfileResponse.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

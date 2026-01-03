import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/datasource/remote/Auth_Repo/auth_repo.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, AuthModel>> sginup(AuthData authData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.sginup,
        data: authData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
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
  Future<Either<Failure, AuthModel>> loginStepOne(AuthData authData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.loginStepOne,
        data: authData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
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
  Future<Either<Failure, AuthModel>> loginStepTwo(AuthData authData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.loginStepTwo,
        data: authData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
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
  Future<Either<Failure, AuthModel>> forgetPassword(AuthData authData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.forgetPassword,
        data: authData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
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
  Future<Either<Failure, AuthModel>> verifyCode(AuthData authData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.verifyCode,
        data: authData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
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
  Future<Either<Failure, AuthModel>> resetPassword(AuthData authData) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.resetPassword,
        data: authData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } catch (e) {
      log(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

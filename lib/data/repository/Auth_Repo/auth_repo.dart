import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/AuthModel/auth_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthModel>> sginup(AuthData authData);
  Future<Either<Failure, AuthModel>> loginStepOne(AuthData authData);
  Future<Either<Failure, AuthModel>> loginStepTwo(AuthData authData);
  Future<Either<Failure, AuthModel>> forgetPassword(AuthData authData);
  Future<Either<Failure, AuthModel>> verifyCode(AuthData authData);
  Future<Either<Failure, AuthModel>> resetPassword(AuthData authData);
  Future<Either<Failure, AuthModel>> updateUser(AuthData authData);
  Future<Either<Failure, bool>> updateFcmToken(String fcmToken);
}

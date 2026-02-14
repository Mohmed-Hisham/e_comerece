import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/user_profile_model.dart';

abstract class UserProfileRepo {
  Future<Either<Failure, UserProfileResponse>> getUserProfile();
  Future<Either<Failure, UserProfileResponse>> updateUserProfile({
    String? name,
    String? phone,
  });
}

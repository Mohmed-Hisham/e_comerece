import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/coupon_model/get_coupon_model.dart';

abstract class CouponRepo {
  Future<Either<Failure, CouponResponse>> getCoupon({required String code});
  Future<Either<Failure, CouponResponse>> useCoupon({
    required String code,
    required String orderid,
  });
}

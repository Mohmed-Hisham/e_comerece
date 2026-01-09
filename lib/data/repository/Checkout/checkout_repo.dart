import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/checkout/checkout_review_fee_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, CheckoutReviewFeeModel>> getCheckOutReviewFee();
}

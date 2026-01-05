import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/address/address_model.dart';

abstract class AddressRepo {
  Future<Either<Failure, List<AddressData>>> getAddresses();
  Future<Either<Failure, AddressModel>> addAddress(AddressData addressData);
  Future<Either<Failure, AddressModel>> updateAddress(AddressData addressData);
  Future<Either<Failure, bool>> deleteAddress(String id);
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/address/address_model.dart';
import 'package:e_comerece/data/repository/Adresess/address_repo.dart';

class AddressRepoImpl implements AddressRepo {
  final ApiService apiServices;
  AddressRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, List<AddressData>>> getAddresses() async {
    try {
      var response = await apiServices.get(endpoint: ApisUrl.getAddresses);
      if (response.statusCode == 200) {
        List responseData = response.data['data'] ?? [];
        return Right(responseData.map((e) => AddressData.fromJson(e)).toList());
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

  @override
  Future<Either<Failure, AddressModel>> addAddress(
    AddressData addressData,
  ) async {
    try {
      var response = await apiServices.post(
        endPoints: ApisUrl.addAddress,
        data: addressData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AddressModel.fromJson(response.data));
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

  @override
  Future<Either<Failure, AddressModel>> updateAddress(
    AddressData addressData,
  ) async {
    try {
      var response = await apiServices.put(
        endPoints: ApisUrl.updateAddress(addressData.id!),
        data: addressData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AddressModel.fromJson(response.data));
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

  @override
  Future<Either<Failure, bool>> deleteAddress(String id) async {
    try {
      var response = await apiServices.delete(
        endPoints: ApisUrl.deleteAddress(id),
      );
      if (response.statusCode == 200) {
        return Right(response.data['success'] ?? true);
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

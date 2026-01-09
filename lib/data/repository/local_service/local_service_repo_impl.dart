import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';
import 'package:e_comerece/data/repository/local_service/local_service_repo.dart';

class LocalServiceRepoImpl implements LocalServiceRepo {
  final ApiService apiService;
  LocalServiceRepoImpl({required this.apiService});
  String msg = "Error occurred";

  @override
  Future<Either<Failure, GetLocalServiceModel>> getLocalService({
    required int page,
    required int pagesize,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getLocalService(page: page, pageSize: pagesize),
      );
      if (response.statusCode == 200) {
        return Right(GetLocalServiceModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message'] ?? msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetLocalServiceModel>> searchLocalService(
    String search,
  ) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.searchLocalService(search),
      );
      if (response.statusCode == 200) {
        return Right(GetLocalServiceModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message'] ?? msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetLocalServiceModel>> getLocalServiceById(
    String id,
  ) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getLocalServiceById(id),
      );
      if (response.statusCode == 200) {
        return Right(GetLocalServiceModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message'] ?? msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addServiceRequest(
    ServiceRequestData serviceRequestData,
  ) async {
    try {
      final response = await apiService.post(
        endPoints: ApisUrl.addServiceRequest,
        data: serviceRequestData.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(response.data['message'] ?? msg);
      } else {
        return Left(ServerFailure(response.data['message'] ?? msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceRequestModel>> getRequestsByUser({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getRequestsByUser(page: page, pageSize: pageSize),
      );
      if (response.statusCode == 200) {
        return Right(ServiceRequestModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message'] ?? msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceRequestDetailsModel>> getServiceRequestDetails(
    String id,
  ) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getServiceRequestDetails(id),
      );
      if (response.statusCode == 200) {
        return Right(ServiceRequestDetailsModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message'] ?? msg));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

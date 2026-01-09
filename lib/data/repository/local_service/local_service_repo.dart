import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/local_service/get_local_service_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_details_model.dart';
import 'package:e_comerece/data/model/local_service/service_request_model.dart';

abstract class LocalServiceRepo {
  Future<Either<Failure, GetLocalServiceModel>> getLocalService({
    required int page,
    required int pagesize,
  });

  Future<Either<Failure, GetLocalServiceModel>> searchLocalService(
    String search,
  );

  Future<Either<Failure, GetLocalServiceModel>> getLocalServiceById(String id);
  Future<Either<Failure, String>> addServiceRequest(
    ServiceRequestData serviceRequestData,
  );
  Future<Either<Failure, ServiceRequestModel>> getRequestsByUser({
    required int page,
    required int pageSize,
  });
  Future<Either<Failure, ServiceRequestDetailsModel>> getServiceRequestDetails(
    String id,
  );
}

import 'package:dio/dio.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:get/get.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(StringsKeys.connectionTimeout.tr);
      case DioExceptionType.sendTimeout:
        return ServerFailure(StringsKeys.sendTimeout.tr);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(StringsKeys.receiveTimeout.tr);
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final data = dioError.response?.data;
        if (statusCode == 401 ||
            statusCode == 400 ||
            statusCode == 403 ||
            statusCode == 404 ||
            statusCode == 405) {
          if (statusCode == 401) {
            return ServerFailure(StringsKeys.unauthorizedPleaseLogin.tr);
          }

          if (statusCode == 404) {
            return ServerFailure(StringsKeys.notFoundError.tr);
          }

          if (data is Map<String, dynamic>) {
            String? errorMessage;

            errorMessage ??= data['message']?.toString();

            return ServerFailure(
              errorMessage ?? StringsKeys.unexpectedServerResponse.tr,
            );
          }

          if (data is String) {
            return ServerFailure(data);
          }

          return ServerFailure(StringsKeys.badResponse.tr);
        } else {
          return ServerFailure(StringsKeys.badRequest.tr);
        }
      case DioExceptionType.cancel:
        return ServerFailure(StringsKeys.requestCancelled.tr);
      case DioExceptionType.unknown:
        return ServerFailure(StringsKeys.unknownError.tr);
      default:
        return ServerFailure(StringsKeys.noInternetConnection.tr);
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return ServerFailure(response['message'] ?? StringsKeys.badRequest.tr);
      case 401:
        return ServerFailure(StringsKeys.unauthorizedError.tr);
      case 403:
        return ServerFailure(StringsKeys.forbiddenError.tr);
      case 404:
        return ServerFailure(StringsKeys.notFoundError.tr);
      case 405:
        return ServerFailure(StringsKeys.bannedError.tr);
      case 500:
        return ServerFailure(StringsKeys.internalServerError.tr);
      default:
        return ServerFailure(StringsKeys.somethingWentWrong.tr);
    }
  }
}

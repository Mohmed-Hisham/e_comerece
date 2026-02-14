import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout!');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout!');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout!');
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final data = dioError.response?.data;
        if (statusCode == 401 ||
            statusCode == 400 ||
            statusCode == 403 ||
            statusCode == 404 ||
            statusCode == 405) {
          if (statusCode == 401) {
            return ServerFailure('Unauthorized, please login again');
          }
          // if (statusCode == 403) {
          //   return ServerFailure('Access Forbidden!');
          // }

          if (statusCode == 404) {
            return ServerFailure('Not Found!');
          }

          if (data is Map<String, dynamic>) {
            String? errorMessage;

            if (data['errors'] != null && data['errors'] is Map) {
              final Map<String, dynamic> errors = data['errors'];
              final List<String> allErrors = [];
              errors.forEach((key, value) {
                if (value is List) {
                  allErrors.addAll(value.map((e) => e.toString()));
                } else if (value != null) {
                  allErrors.add(value.toString());
                }
              });
              if (allErrors.isNotEmpty) {
                errorMessage = allErrors.join('. ');
              }
            }

            errorMessage ??= data['message']?.toString();

            return ServerFailure(errorMessage ?? 'Unexpected server response');
          }

          if (data is String) {
            return ServerFailure(data);
          }

          return ServerFailure('Bad Response!');
        } else {
          return ServerFailure('Bad Request!');
        }
      case DioExceptionType.cancel:
        return ServerFailure('');
      case DioExceptionType.unknown:
        return ServerFailure('Unknown Error!');
      default:
        return ServerFailure('Check Your Enternet Connection');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return ServerFailure(response['message'] ?? 'Bad Request!');
      case 401:
        return ServerFailure('Unauthorized!');
      case 403:
        return ServerFailure('Forbidden!');
      case 404:
        return ServerFailure('Not Found!');
      case 405:
        return ServerFailure('Banned');
      case 500:
        return ServerFailure('Internal Server Error!');
      default:
        return ServerFailure('Oops, something went wrong!');
    }
  }
}

// vudc syhh dnhq uywj
// nodemailer password in backend

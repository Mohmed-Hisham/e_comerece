import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/class/api_service.dart';
import '../../../../core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import '../../model/ordres/get_order_with_status_model.dart';
import '../../model/ordres/create_order_request.dart';
import '../../model/ordres/order_details_model.dart';
import 'orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  final ApiService apiService;
  OrdersRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, GetOrderWithStatusModel>> getUserOrders({
    required String status,
    required int page,
    required int pageSize,
  }) async {
    try {
      var response = await apiService.get(
        endpoint: ApisUrl.getOrdersByUser(status, page, pageSize),
      );
      if (response.statusCode == 200) {
        return Right(GetOrderWithStatusModel.fromJson(response.data));
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
  Future<Either<Failure, Map<String, dynamic>>> createOrder(
    CreateOrderRequest request,
  ) async {
    try {
      var response = await apiService.post(
        endPoints: ApisUrl.createOrder,
        data: request.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data);
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
  Future<Either<Failure, OrderDetailsModel>> getOrderDetails(
    String orderId,
  ) async {
    try {
      var response = await apiService.get(
        endpoint: ApisUrl.orderDetails(orderId),
      );
      if (response.statusCode == 200) {
        return Right(OrderDetailsModel.fromJson(response.data));
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

import 'package:dartz/dartz.dart';
import '../../../../core/class/failure.dart';
import '../../model/ordres/get_order_with_status_model.dart';
import '../../model/ordres/create_order_request.dart';
import '../../model/ordres/order_details_model.dart';

abstract class OrdersRepo {
  Future<Either<Failure, GetOrderWithStatusModel>> getUserOrders({
    required String status,
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, Map<String, dynamic>>> createOrder(
    CreateOrderRequest request,
  );

  Future<Either<Failure, OrderDetailsModel>> getOrderDetails(String orderId);
}

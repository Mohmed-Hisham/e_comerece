import 'package:e_comerece/data/datasource/remote/local_service/view_orders_data.dart';
import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/statusrequest.dart';

class LocalServiceRepo {
  ViewOrdersData viewOrdersData;

  LocalServiceRepo(this.viewOrdersData);

  Future<Either<Statusrequest, Map>> getOrders(
    String userid,
    String status,
  ) async {
    var response = await viewOrdersData.viewOrders(
      userid: userid,
      status: status,
    );
    if (response is Statusrequest) {
      return Left(response);
    } else {
      return Right(response);
    }
  }
}

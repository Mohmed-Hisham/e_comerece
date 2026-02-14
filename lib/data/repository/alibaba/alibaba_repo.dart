import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_byimage_model.dart';
import 'package:e_comerece/data/model/alibaba_model/productalibaba_home_model.dart';
import 'package:e_comerece/data/model/alibaba_model/product_ditels_alibaba_model.dart';

abstract class AlibabaRepo {
  Future<Either<Failure, ProductAliBabaHomeModel>> fetchProducts(
    String lang,
    int page,
    String q,
  );
  Future<Either<Failure, ProductAliBabaHomeModel>> searchProducts(
    String lang,
    int page,
    String keyword,
    String startPrice,
    String endPrice,
  );
  Future<Either<Failure, ProductAliBabaByImageModel>> fetchSearchByImage(
    String lang,
    String imageUrl,
    int page,
  );
  Future<Either<Failure, ProductDitelsAliBabaModel>> fetchProductDetails(
    String lang,
    String productId,
  );
}

import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/shein_models/catgory_shein_model.dart';

import 'package:e_comerece/data/model/shein_models/searsh_shein_model.dart';
import 'package:e_comerece/data/model/shein_models/details_shein_image_list.dart';
import 'package:e_comerece/data/model/shein_models/details_shein_size.dart';
import 'package:e_comerece/data/model/shein_models/product_ditels_shein_model.dart';
import 'package:e_comerece/data/model/shein_models/trending_products_model.dart';

abstract class SheinRepo {
  Future<Either<Failure, CatgorySheinModel>> fetchCategories(String lang);
  Future<Either<Failure, TrendingProductsModel>> fetchTrendingProducts(
    String lang,
    int page,
  );
  Future<Either<Failure, SeachSheinModel>> searchProducts(
    String lang,
    String keyword,
    int page,
    String startPrice,
    String endPrice,
  );
  Future<Either<Failure, ProductDitelsSheinDart>> fetchProductDetails(
    String goodssn,
    String lang,
  );
  Future<Either<Failure, DetailsSheinImageList>> fetchProductDetailsImageList(
    String goodssn,
    String lang,
  );
  Future<Either<Failure, DetailsSheinSize>> fetchProductDetailsSize(
    String goodsid,
    String lang,
  );
  Future<Either<Failure, SeachSheinModel>> fetchProductsByCategories(
    String categoryId,
    String categoryName,
    String pageindex,
    String countryCode,
  );
}

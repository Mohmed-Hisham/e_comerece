import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/amazon_models/categories_amazon_model.dart';
import 'package:e_comerece/data/model/amazon_models/hotdeals_amazon_model.dart';
import 'package:e_comerece/data/model/amazon_models/details_amazon_model.dart';
import 'package:e_comerece/data/model/amazon_models/search_amazon_model.dart';

abstract class AmazonRepo {
  Future<Either<Failure, CategoriesAmazonModel>> fetchCategories(String lang);
  Future<Either<Failure, HotDealsAmazonModel>> fetchHotDeals(String lang);
  Future<Either<Failure, SearchAmazonModel>> searchProducts(
    String lang,
    String keyword,
    int page,
    String startPrice,
    String endPrice,
  );
  Future<Either<Failure, DetailsAmazonModel>> fetchProductDetails(
    String asin,
    String lang,
  );
}

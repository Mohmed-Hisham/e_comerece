import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/aliexpriess_model/category_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/hotproductmodel.dart';
import 'package:e_comerece/data/model/aliexpriess_model/itemdetelis_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/searchbyimage_model.dart';
import 'package:e_comerece/data/model/aliexpriess_model/shearch_model.dart';

abstract class AlexpressRepo {
  Future<Either<Failure, CategorisModel>> fetchCategories(String lang);
  Future<Either<Failure, HotProductModel>> fetchProducts(
    String lang,
    int page,
    String query,
  );
  Future<Either<Failure, HotProductModel>> searchProducts(
    String lang,
    int page,
    String keyword,
  );
  Future<Either<Failure, SearchByImageModel>> fetchSearchByImage(
    String lang,
    String imageUrl,
  );
  Future<Either<Failure, SearchFromCatModel>> searchByName(
    String lang,
    String keyword,
    int page,
    int categoryId,
  );
  Future<Either<Failure, ItemDetailsModel>> fetchProductDetails(
    String lang,
    int productId,
  );
}

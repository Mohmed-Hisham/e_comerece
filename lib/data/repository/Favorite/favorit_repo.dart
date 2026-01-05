import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/model/favorite_model.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, FavoriteModel>> getAll();
  Future<Either<Failure, FavoriteModel>> getByPlatform(String platform);
  Future<Either<Failure, String>> add(Product product);
  Future<Either<Failure, String>> delete(String favoriteId);
}

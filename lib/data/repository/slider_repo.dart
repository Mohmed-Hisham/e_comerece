import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/class/api_service.dart';
import 'package:e_comerece/core/class/failure.dart';
import 'package:e_comerece/data/Apis/apis_url.dart';
import 'package:e_comerece/data/model/slider_model.dart';

abstract class SliderRepo {
  Future<Either<Failure, List<SliderModel>>> getSliders({String? platform});
}

class SliderRepoImpl extends SliderRepo {
  final ApiService apiService;

  SliderRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<SliderModel>>> getSliders({
    String? platform,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: ApisUrl.getSlider(platform: platform),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<SliderModel> sliders = data
            .map((e) => SliderModel.fromJson(e))
            .toList();
        return Right(sliders);
      } else {
        return Left(ServerFailure(response.statusMessage ?? "Error"));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

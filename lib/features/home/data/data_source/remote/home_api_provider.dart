import 'package:bloc_hive_caching_data/config/constants/api_constants.dart';
import 'package:bloc_hive_caching_data/core/helper/log_helper.dart';
import 'package:dio/dio.dart';

class HomeApiProvider {
  final Dio dio;

  // public constructor
  HomeApiProvider(this.dio);

  /// call home page products data

  /// call home page products data
  dynamic callHomeProductsEndPoint() async {
    final requestUrl = EnvironmentVariables.getProducts;
    final response = await dio
        .request(requestUrl, options: Options(method: "GET"))
        .onError((DioException error, stackTrace) {
          logger.e(error.toString());
          throw error;
        });
    return response;
  }
}

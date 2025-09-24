import 'package:bloc_hive_caching_data/core/helper/log_helper.dart';
import 'package:bloc_hive_caching_data/features/home/data/data_source/local/home_db_service.dart';
import 'package:bloc_hive_caching_data/features/home/data/models/product_model.dart';

class HomeDatabaseProvider {
  final HomeDataBaseService _homeDataBaseService;
  HomeDatabaseProvider({required HomeDataBaseService homeDataBaseService})
    : _homeDataBaseService = homeDataBaseService;

  /// Read from database
  Future<ProductsModel?> getProducts() async {
    try {
      return await _homeDataBaseService.getAll();
    } catch (e) {
      logger.e('Error retrieving products: $e');
      return null;
    }
  }

  /// insert into database
  Future<void> insertProducts({required ProductsModel object}) async {
    try {
      await _homeDataBaseService.insertItem(object: object);
    } catch (e) {
      logger.e('Error insert into products: $e');
    }
  }

  /// is data available
  // Is Data Available
  Future<bool> isPostDataAvailable() async {
    return await _homeDataBaseService.isDataAvailable();
  }
}

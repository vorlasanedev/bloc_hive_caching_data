import 'package:bloc_hive_caching_data/config/constants/db_keys.dart';
import 'package:bloc_hive_caching_data/core/helper/log_helper.dart';
import 'package:bloc_hive_caching_data/core/repos/interface_repos.dart';
import 'package:bloc_hive_caching_data/features/home/data/models/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeDataBaseService implements InterfaceRepository<ProductsModel> {
  /// Box key
  static const String _key = DbKeys.dbProducts;

  /// Product box
  late final Box<ProductsModel> _productBox;

  /// init database
  Future<void> initDatabase() async {
    try {
      Hive.registerAdapter(ProductsModelAdapter());
      Hive.registerAdapter(ProductAdapter());
      _productBox = await Hive.openBox(_key);
      logger.d('Success on initailizing database for *ProductModel*');
    } catch (e) {
      logger.e('Error initializing database for *ProductModel*');
    }
  }

  @override
  Future<ProductsModel?> getAll() async {
    try {
      if (_productBox.isOpen && _productBox.isNotEmpty) {
        return _productBox.get(_key);
      } else {
        return null;
      }
    } catch (e) {
      logger.e('Error reading from database: $e');
      return null;
    }
  }

  @override
  Future<void> insertItem({required ProductsModel object}) async {
    try {
      await _productBox.put(_key, object);
    } catch (e) {
      logger.e('Error insert into to database: $e');
    }
  }

  @override
  Future<bool> isDataAvailable() async {
    try {
      return _productBox.isEmpty;
    } catch (e) {
      logger.e('Error checking if box is empty: $e');
      return true;
    }
  }
}

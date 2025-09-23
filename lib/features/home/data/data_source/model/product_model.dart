import 'package:bloc_hive_caching_data/features/home/data/data_source/model/hive_helper/fields/product_fields.dart';
import 'package:hive/hive.dart';
import 'package:bloc_hive_caching_data/features/home/data/data_source/model/hive_helper/hive_types.dart';
import 'package:bloc_hive_caching_data/features/home/data/data_source/model/hive_helper/fields/product_model_fields.dart';

part 'product_model.g.dart';

@HiveType(typeId: HiveTypes.productModel)
class ProductModel extends HiveObject {
  @HiveField(ProductModelFields.success)
  final bool success;
  @HiveField(ProductModelFields.totalProducts)
  final int totalProducts;
  @HiveField(ProductModelFields.message)
  final String message;
  @HiveField(ProductModelFields.offset)
  final int offset;
  @HiveField(ProductModelFields.limit)
  final int limit;
  @HiveField(ProductModelFields.products)
  final List products;
  ProductModel({
    required this.success,
    required this.totalProducts,
    required this.message,
    required this.offset,
    required this.limit,
    required this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    success: json['success'],
    totalProducts: json['total_products'],
    message: json['message'],
    offset: json['offset'],
    limit: json['limit'],
    products: List<Product>.from(
      json['products'].map((x) => Product.fromJson(x)),
    ),
  );
}

@HiveType(typeId: HiveTypes.product)
class Product extends HiveObject {
  @HiveField(ProductFields.id)
  final int id;
  @HiveField(ProductFields.price)
  final double price;
  @HiveField(ProductFields.category)
  final String category;
  @HiveField(ProductFields.updatedAt)
  final DateTime updatedAt;
  @HiveField(ProductFields.photoUrl)
  final String photoUrl;
  @HiveField(ProductFields.name)
  final String name;
  @HiveField(ProductFields.description)
  final String description;
  @HiveField(ProductFields.createdAt)
  final DateTime createdAt;
  Product({
    required this.id,
    required this.price,
    required this.category,
    required this.updatedAt,
    required this.photoUrl,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    price: json['price'],
    category: json['category'],
    updatedAt: DateTime.parse(json['updateAt']),
    photoUrl: json['photoUrl'],
    name: json['name'],
    description: json['description'],
    createdAt: DateTime.parse(json['createAt']),
  );
}

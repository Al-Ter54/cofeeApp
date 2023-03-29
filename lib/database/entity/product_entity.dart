
import 'package:floor/floor.dart';

@entity
class ProductEntity {
  @primaryKey
  final int id;
  final String name;
  final int? categoryId;
  final double price;
  final String image;
  String get imageUrl => "https://firtman.github.io/coffeemasters/api/images/$image";

  ProductEntity({
    required this.id,
    required this.name,
    this.categoryId,
    required this.price,
    required this.image,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json, int? categoryId) {
    return ProductEntity(
      id: json["id"] as int,
      name: json["name"] as String,
      categoryId: categoryId,
      price: json["price"] as double,
      image: json["image"] as String,
    );
  }
}

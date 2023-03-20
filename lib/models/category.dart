import 'package:cofee/models/product.dart';

class Category {
  Category({
    required this.name,
    required this.products,
  });

  String name;
  List<Product> products;

  factory Category.fromJson(Map<String, dynamic> json) {
    var productsJson = json["products"] as Iterable<dynamic>;
    var products = productsJson.map((p) => Product.fromJson(p)).toList();
    return Category(name: json["name"] as String, products: products);
  }
}

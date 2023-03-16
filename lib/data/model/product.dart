class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  String get imageUrl => "https://firtman.github.io/coffeemasters/api/images/$image";

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] as int,
      name: json["name"] as String,
      price: json["price"] as double,
      image: json["image"] as String,
    );
  }
}

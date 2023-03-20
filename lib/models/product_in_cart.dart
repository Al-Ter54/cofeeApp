import 'package:cofee/models/product.dart';

class ProductInCart {
  Product product;
  int quantity;

  ProductInCart({
    required this.product,
    required this.quantity,
  });
}

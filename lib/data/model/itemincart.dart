import 'package:cofee/data/model/product.dart';

class ItemInCart {
  Product product;
  int quantity;
  ItemInCart({required this.product, required this.quantity});
}
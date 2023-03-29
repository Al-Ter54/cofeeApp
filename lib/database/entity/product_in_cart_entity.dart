import 'package:floor/floor.dart';

@entity
class ProductInCartEntity {
  ProductInCartEntity({
    required this.productId,
    required this.quantity,
  });

  @primaryKey
  final int productId;
  final int quantity;
}

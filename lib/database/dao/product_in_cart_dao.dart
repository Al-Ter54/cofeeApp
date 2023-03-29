import 'package:floor/floor.dart';

import '../entity/product_in_cart_entity.dart';

@dao
abstract class ProductInCartDao {
  @Query("SELECT * FROM ProductInCartEntity")
  Future<List<ProductInCartEntity>> findAllProductsInCart();

  @Query("SELECT * FROM ProductInCartEntity WHERE productId = :productId")
  Future<ProductInCartEntity?> findProductInCartByProductId(int productId);

  @Query("DELETE FROM ProductInCartEntity")
  Future<void> clear();

  @insert
  Future<void> insertProductInCart(ProductInCartEntity productInCartEntity);

  @update
  Future<void> updateProductInCart(ProductInCartEntity productInCartEntity);

  @delete
  Future<void> deleteProductInCart(ProductInCartEntity productInCartEntity);
}

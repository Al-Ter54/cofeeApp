import 'package:floor/floor.dart';

import '../entity/product_entity.dart';

@dao
abstract class ProductDao {

  @Query("SELECT * FROM ProductEntity WHERE id = :id")
  Future<ProductEntity?> findProductById(int id);

  @Query("SELECT * FROM ProductEntity WHERE categoryId = :categoryId")
  Future<List<ProductEntity>> findProductsByCategoryId(int categoryId);

  @Query("SELECT * FROM ProductEntity")
  Future<List<ProductEntity>> findAllProducts();

  @Query("DELETE FROM ProductEntity")
  Future<void> clear();

  @insert
  Future<void> insertProduct(ProductEntity productEntity);
}
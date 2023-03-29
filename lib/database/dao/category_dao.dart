import 'package:cofee/database/entity/category_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class CategoryDao{
  @Query("SELECT * FROM CategoryEntity")
  Future<List<CategoryEntity>> findAllCategories();

  @Query("SELECT * FROM CategoryEntity WHERE id = :id")
  Future<CategoryEntity?> findCategoryById(int id);

  @Query("SELECT * FROM CategoryEntity WHERE name = :name")
  Future<CategoryEntity?> findCategoryByName(String name);

  @Query("DELETE FROM CategoryEntity")
  Future<void> clear();

  @insert
  Future<int> insertCategory(CategoryEntity categoryEntity);

}
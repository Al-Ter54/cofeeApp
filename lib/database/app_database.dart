import 'dart:async';

import 'package:cofee/database/dao/category_dao.dart';
import 'package:cofee/database/dao/product_dao.dart';
import 'package:cofee/database/dao/product_in_cart_dao.dart';
import 'package:cofee/database/entity/category_entity.dart';
import 'package:cofee/database/entity/product_entity.dart';
import 'package:cofee/database/entity/product_in_cart_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [
  CategoryEntity,
  ProductEntity,
  ProductInCartEntity,
])
abstract class AppDatabase extends FloorDatabase {
  CategoryDao get categoryDao;

  ProductDao get productDao;

  ProductInCartDao get productInCartDao;
}

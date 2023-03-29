import 'dart:convert';
import 'dart:io';

import 'package:cofee/database/entity/category_entity.dart';
import 'package:cofee/database/entity/product_entity.dart';
import 'package:http/http.dart' as http;

import '../database/app_database.dart';
import '../models/category.dart';

class CategoryService {
  CategoryService(this._appDatabase);

  final AppDatabase _appDatabase;

  Future<void> updateCategories() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      await _appDatabase.categoryDao.findAllCategories().then((value) async {
        if (value.isNotEmpty) {
          await _appDatabase.productDao.clear();
          await _appDatabase.categoryDao.clear();
        }
      });
      var body = response.body;
      var decodeData = jsonDecode(body) as List<dynamic>;
      for (var json in decodeData) {
        final category = Category.fromJson(json);
        int categoryId = await _appDatabase.categoryDao.insertCategory(
          CategoryEntity(name: category.name),
        );
        for (var element in category.products) {
          ProductEntity product = ProductEntity(
            id: element.id,
            name: element.name,
            price: element.price,
            image: element.image,
            categoryId: categoryId,
          );
          _appDatabase.productDao.insertProduct(
            product,
          );
        }
      }
    }
  }

  Future<bool> internetConnectionCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> getCategoriesFromRemote() async {
    final connection = await internetConnectionCheck();
    if (connection) {
      await updateCategories();
    }

    // internet().then((value) {
    //       if (value) {updateCategories();}
    //     });
  }

  Future<List<CategoryEntity>> getCategories() {
    return _appDatabase.categoryDao.findAllCategories();
  }

  Future<List<ProductEntity>> getProducts() {
    return _appDatabase.productDao.findAllProducts();
  }

  Future<ProductEntity?> getProductById(int id) {
    return _appDatabase.productDao.findProductById(id);
  }
}

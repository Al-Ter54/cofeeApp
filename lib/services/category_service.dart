import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category.dart';

class CategoryService {
  List<Category>? _menu;

  Future<void> fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = response.body;
      _menu = [];
      var decodeData = jsonDecode(body) as List<dynamic>;
      for (var json in decodeData) {
        _menu?.add(Category.fromJson(json));
      }
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }
}

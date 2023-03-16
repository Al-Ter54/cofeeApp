import 'dart:convert';

import 'package:cofee/data/model/product.dart';

import '../model/category.dart';
import '../model/itemincart.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];
  fetchMenu() async{
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var body = response.body;
      _menu = [];
      var decodeData = jsonDecode(body) as List<dynamic>;
      for(var json in decodeData){
        _menu?.add(Category.fromJson(json));
      }
    }
  }
  Future<List<Category>> getMenu() async {
    if(_menu == null){
      await fetchMenu();
    }
    return _menu!;
  }

  cartAdd(Product product){
    bool found = false;
    for(var item in cart){
      if(item.product.id == product.id){
        item.quantity++;
        found = true;
      }
    }
    if(!found){
      cart.add(ItemInCart(product: product, quantity: 1));
    }

  }
  cartRemove(Product product){
    cart.removeWhere((item) => item.product.id == product.id);
  }
  cartClear(){
    cart.clear();
  }
  double cartTotal(){
    double total = 0;
    for(var item in cart){
      total += item.product.price*item.quantity;
    }
    return total;
  }
}
import 'package:cofee/database/app_database.dart';
import 'package:cofee/database/entity/product_in_cart_entity.dart';

import '../models/product.dart';

class CartService {
  CartService(this._appDatabase);

  final AppDatabase _appDatabase;

  Future<List<ProductInCartEntity>> cartGet() async {
    return await _appDatabase.productInCartDao.findAllProductsInCart();
  }
  cartAdd(Product product) async {
    bool found = false;
    final cart = await _appDatabase.productInCartDao.findAllProductsInCart();
    for (var item in cart) {
      if (item.productId == product.id) {
        await _appDatabase.productInCartDao
            .updateProductInCart(ProductInCartEntity(
          productId: item.productId,
          quantity: item.quantity + 1,
        ));
        found = true;
      }
    }
    if (!found) {
      await _appDatabase.productInCartDao
          .insertProductInCart(ProductInCartEntity(
        productId: product.id,
        quantity: 1,
      ));
    }
  }

  cartRemove(Product product) async{
    final productInCartEntity = await _appDatabase.productInCartDao.findProductInCartByProductId(product.id);
    if(productInCartEntity != null) {
      await _appDatabase.productInCartDao.deleteProductInCart(productInCartEntity);
    }
  }

  cartClear() async{
    await _appDatabase.productInCartDao.clear();
  }
}

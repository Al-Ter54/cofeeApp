import '../models/product.dart';
import '../models/product_in_cart.dart';

class CartService {
  List<ProductInCart> cart = [];

  cartAdd(Product product) {
    bool found = false;
    for (var item in cart) {
      if (item.product.id == product.id) {
        item.quantity++;
        found = true;
      }
    }
    if (!found) {
      cart.add(ProductInCart(product: product, quantity: 1));
    }
  }

  cartRemove(Product product) {
    cart.removeWhere((item) => item.product.id == product.id);
  }

  cartClear() {
    cart.clear();
  }

  double cartTotal() {
    double total = 0;
    for (var item in cart) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}

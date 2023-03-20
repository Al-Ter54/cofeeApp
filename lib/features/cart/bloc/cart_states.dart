import '../../../models/product_in_cart.dart';

abstract class CartState {}

class CartStateLoading extends CartState {}

class CartStateLoaded extends CartState {
  final List<ProductInCart> cart;

  CartStateLoaded(this.cart);
}

class CartStateError extends CartState {}

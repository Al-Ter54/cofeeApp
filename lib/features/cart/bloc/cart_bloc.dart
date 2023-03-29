import 'package:cofee/models/product.dart';
import 'package:cofee/services/cart_service.dart';
import 'package:cofee/features/cart/bloc/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product_in_cart.dart';
import '../../../services/category_service.dart';
import 'cart_events.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartBloc({required this.categoryService, required this.cartService})
      : super(CartStateLoading()) {
    on<CartEventStarted>(_onInit);
    on<CartEventAdd>(_onAdd);
    on<CartEventRemove>(_onRemove);
    on<CartEventClear>(_onClear);
  }

  final CartService cartService;
  final CategoryService categoryService;

  Future<void> _onInit(
    CartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartStateLoading());
    try {
      final cart = await getCart();
      emit(CartStateLoaded(cart));
    } catch (_) {
      emit(CartStateError());
    }
  }

  Future<void> _onAdd(
    CartEventAdd event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartStateLoaded) {
      try {
        await cartService.cartAdd(event.item);
        final cart = await getCart();
        emit(CartStateLoaded(cart));
      } catch (_) {
        emit(CartStateError());
      }
    }
  }

  Future<void> _onRemove(
    CartEventRemove event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartStateLoaded) {
      try {
        await cartService.cartRemove(event.item);
        final cart = await getCart();
        emit(CartStateLoaded(cart));
      } catch (_) {
        emit(CartStateError());
      }
    }
  }

  Future<void> _onClear(
    CartEventClear event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartStateLoaded) {
      try {
        await cartService.cartClear();
        final cart = await getCart();
        emit(CartStateLoaded(cart));
      } catch (_) {
        emit(CartStateError());
      }
    }
  }
  Future<List<ProductInCart>> getCart() async {

    List<ProductInCart> cart = [];
    final cartFromDb = await cartService.cartGet();
    for (final cartItem in cartFromDb) {
      final product =
      await categoryService.getProductById(cartItem.productId);
      if (product != null) {
        cart.add(ProductInCart(
          product: Product(
            id: product.id,
            name: product.name,
            price: product.price,
            image: product.image,
          ),
          quantity: cartItem.quantity,
        ));
      }
    }
    return cart;
  }
}

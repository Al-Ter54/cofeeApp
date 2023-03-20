import 'package:cofee/services/cart_service.dart';
import 'package:cofee/features/cart/bloc/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product_in_cart.dart';
import 'cart_events.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.cartService}) : super(CartStateLoading()) {
    on<CartEventStarted>(_onInit);
    on<CartEventAdd>(_onAdd);
    on<CartEventRemove>(_onRemove);
    on<CartEventClear>(_onClear);
    add(CartEventStarted());
  }

  final CartService cartService;

  Future<void> _onInit(
    CartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartStateLoading());
    try {
      List<ProductInCart> cart = cartService.cart;
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
        cartService.cartAdd(event.item);
        List<ProductInCart> cart = cartService.cart;
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
        cartService.cartRemove(event.item);
        List<ProductInCart> cart = cartService.cart;
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
        cartService.cartClear();
        List<ProductInCart> cart = cartService.cart;
        emit(CartStateLoaded(cart));
      } catch (_) {
        emit(CartStateError());
      }
    }
  }
}

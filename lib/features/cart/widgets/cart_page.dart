import 'package:cofee/features/cart/bloc/cart_bloc.dart';
import 'package:cofee/features/cart/bloc/cart_events.dart';
import 'package:cofee/features/cart/widgets/cart_item.dart';
import 'package:cofee/features/cart/bloc/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      final cartBloc = context.read<CartBloc>();
      return _body(state: state, cartBloc: cartBloc);
    });
  }

  Widget _body({
    required CartState state,
    required CartBloc cartBloc,
  }) {
    switch (state.runtimeType) {
      case CartStateLoading:
        return const CircularProgressIndicator();
      case CartStateLoaded:
        state as CartStateLoaded;
        return ListView.builder(
          itemCount: state.cart.length,
          itemBuilder: ((context, index) {
            var item = state.cart[index];
            return CartItem(
                item: item,
                onRemove: (product) {
                  cartBloc.add(CartEventRemove(product));
                });
          }),
        );
      case CartStateError:
        return const Text("Something went wrong");
      default:
        return const Text("Wrong event type");
    }
  }
}

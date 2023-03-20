import 'package:flutter/material.dart';

import '../../../models/product_in_cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.item,
    required this.onRemove,
  }) : super(key: key);
  final ProductInCart item;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${item.quantity}x"),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                item.product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                  "\$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onRemove(item.product);
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

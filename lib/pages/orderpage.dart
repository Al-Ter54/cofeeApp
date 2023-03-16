import 'package:cofee/items/orderitem.dart';
import 'package:flutter/material.dart';

import '../data/manager/datamanager.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key, required this.dataManager}) : super(key: key);
  final DataManager dataManager;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataManager.cart.isEmpty) {
      return const Center(
        child: Text(
          "Your cart is Empty",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: widget.dataManager.cart.length,
        itemBuilder: ((context, index) {
          var item = widget.dataManager.cart[index];
          return OrderItem(
              item: item,
              onRemove: (product) {
                setState(() {
                  widget.dataManager.cartRemove(product);
                });
              });
        }),
      );
    }
  }
}

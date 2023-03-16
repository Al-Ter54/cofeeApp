import 'package:flutter/material.dart';

import '../data/model/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.product, required this.onAdd}) : super(key: key);

  final Product product;
  final Function onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
                child: Image.network(product.imageUrl),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name),
                      Text("\$${product.price.toStringAsFixed(2)}"),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {onAdd(product);},
                    child: const Text("Add to cart"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cofee/data/manager/datamanager.dart';
import 'package:cofee/items/productitem.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key, da, required this.dataManager}) : super(key: key);
  final DataManager dataManager;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataManager.getMenu(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          var categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categories[index].name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: categories[index].products.length,
                    itemBuilder: ((context, indexProduct) {
                      var product = categories[index].products[indexProduct];
                      return ProductItem(
                        product: product,
                        onAdd: (product) {
                          dataManager.cartAdd(product);
                        },
                      );
                    }),
                  )
                ],
              );
            }),
          );
        } else if (snapshot.hasError) {
          return const Text("Error");
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}

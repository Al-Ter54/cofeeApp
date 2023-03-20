import 'package:cofee/features/categories/bloc/category_bloc.dart';
import 'package:cofee/features/categories/bloc/caterory_events.dart';
import 'package:cofee/features/categories/widget/product_item.dart';
import 'package:cofee/features/categories/bloc/category_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/category.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CategoryBloc>();

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, CategoryState state) {
        return _body(state: state, bloc: bloc);
      },
    );
  }

  Widget _body({
    required CategoryState state,
    required CategoryBloc bloc,
  }) {
    switch (state.runtimeType) {
      case CategoryStateLoading:
        return const CircularProgressIndicator();

      case CategoryStateLoaded:
        var categories = (state as CategoryStateLoaded).categories;
        return _categoryList(categories: categories, bloc: bloc);

      case CategoryStateError:
        return const Text("Something went wrong");
      default:
        return const Text("Wrong event type");
    }
  }

  Widget _categoryList({
    required List<Category> categories,
    required CategoryBloc bloc,
  }) {
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
                    bloc.add(
                      CategoryEventAddToCart(product),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}

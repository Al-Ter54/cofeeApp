import 'package:flutter/material.dart';

import '../features/cart/widgets/cart_page.dart';
import '../features/categories/widget/category_page.dart';
import '../features/offers/widget/offers_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const CategoryPage();
    switch (selectedIndex) {
      case 0:
        currentWidgetPage = const CategoryPage();
        break;
      case 1:
        currentWidgetPage = const OffersPage();
        break;
      case 2:
        currentWidgetPage = const CartPage();
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coffee homepage"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Menu",
            icon: Icon(Icons.menu_book),
            tooltip: "Actual menu",
          ),
          BottomNavigationBarItem(
            label: "Offers",
            icon: Icon(Icons.local_offer_outlined),
            tooltip: "List of Offers",
          ),
          BottomNavigationBarItem(
            label: "Order",
            icon: Icon(Icons.shopping_cart),
            tooltip: "List of Products in cart",
          ),
        ],
      ),
      body: currentWidgetPage,
    );
  }
}

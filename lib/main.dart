import 'package:cofee/data/manager/datamanager.dart';
import 'package:cofee/pages/menupage.dart';
import 'package:cofee/pages/offerspage.dart';
import 'package:cofee/pages/orderpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        // useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.brown,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          headlineSmall: TextStyle(
            color: Colors.brown,
            fontSize: 20,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = MenuPage(
      dataManager: dataManager,
    );
    switch (selectedIndex) {
      case 0:
        currentWidgetPage = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentWidgetPage = const OffersPage();
        break;
      case 2:
        currentWidgetPage = OrderPage(
          dataManager: dataManager,
        );
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

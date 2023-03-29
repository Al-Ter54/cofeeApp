import 'package:cofee/database/app_database.dart';
import 'package:cofee/features/cart/bloc/cart_bloc.dart';
import 'package:cofee/features/categories/bloc/category_bloc.dart';
import 'package:cofee/pages/home_page.dart';
import 'package:cofee/services/cart_service.dart';
import 'package:cofee/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();

  var appDatabase = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  runApp(
    MyApp(
      cartService: CartService(appDatabase),
      categoryService: CategoryService(appDatabase),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.cartService,
    required this.categoryService,
  });

  final CartService cartService;
  final CategoryService categoryService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CartBloc(
            categoryService: categoryService,
            cartService: cartService,
          ),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryService: categoryService,
            cartService: cartService,
          ),
        ),
      ],
      child: MaterialApp(
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
        home: const HomePage(),
      ),
    );
  }
}
